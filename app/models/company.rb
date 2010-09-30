class Company < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :delivery_orders, :dependent => :destroy
  has_many :sales_invoices, :dependent => :destroy
  validates_presence_of :subdomain
  validates_uniqueness_of :subdomain
  validates_format_of :subdomain, :with => /^[a-zA-Z0-9\-]*?$/, :message => 'only accepts letters, numbers, and hypens'
  has_many :users, :dependent => :destroy
  has_many :categories, :dependent => :destroy
  has_many :items, :dependent => :destroy
  has_many :suppliers, :dependent => :destroy
  has_many :plus, :dependent => :destroy
  has_many :warehouses, :dependent => :destroy
  has_many :locations, :dependent => :destroy
  has_many :begining_balances, :dependent => :destroy
  has_many :transaction_types, :dependent => :destroy
  has_many :general_transactions, :dependent => :destroy
  has_many :trackers, :dependent => :destroy
  has_many :transactions, :dependent => :destroy
  has_many :entries, :dependent => :destroy
  has_many :assemblies, :dependent => :destroy
  has_many :customers, :dependent => :destroy
  has_many :price_lists, :dependent => :destroy
  has_many :material_requests, :dependent => :destroy
  has_many :quotation_requests, :dependent => :destroy
  has_many :purchase_orders, :dependent => :destroy
  has_many :purchase_returns, :dependent => :destroy
  has_many :quotations, :dependent => :destroy
  has_many :sales_orders, :dependent => :destroy
  has_many :salesmen, :dependent => :destroy
  has_many :currencies, :dependent => :destroy
  has_many :exchange_rates, :dependent => :destroy
  has_many :roles, :dependent => :destroy
  has_many :trans_assemblies, :dependent => :destroy
  has_many :item_receives, :class_name => "ItemReceive", :dependent => :destroy
  has_many :trans_diassemblies, :dependent => :destroy

  default_scope :order => :created_at
  after_create :create_defaults

  def next_stock
    available = trackers.available_transaction
    available.blank? ? transactions.inward.first : available
  end

  def default_warehouse
    warehouses.first(:conditions => { :default => true })
  end

  def sorted_categories
    cat = []; categories.roots.each do |root|
      cat << root << root.descendants
    end
    cat.flatten
  end

  def leaf_categories
    categories.all(:order => :name).reject { |cat| !cat.leaf? }
  end

  def first_transaction_date
    Transaction.first(:conditions => { :company_id => self.id }, :order => 'created_at ASC').created_at
  end

  def stock
    @stock || Stock.new(self)
  end

  def item_movement_report(from, to, category, warehouse, types)
    # assume every par ams has value(s)
    entries = Entry.transaction_created_at_gte(from.to_s( :db)).transaction_created_at_lte(to.to_s(:db)).transaction_type_not('BeginingBalance')
    entries = entries.transaction_origin_id_or_transaction_destination_id_is(warehouse) unless warehouse.blank?
    if category
      cat = Category.find(category)
      entries = cat.leaf? ? entries.item_category_id_is(cat) : entries.item_category_id_in(cat.leaf_ids)
    end
    #all_items = items.ascend_by_name
    rows = []
    entries.each do |entry|
      eid = entry.item.id
      rows[eid] = {} if rows[eid].blank?
      rows[eid][:item] = entry.item if rows[eid][:item].blank?
      rows[eid][:start_balance] = entry.item.on_hand_until(from - 1.day) if rows[eid][:start_balance].blank?
      rows[eid][:end_balance] = entry.item.stock if rows[eid][:end_balance].blank?
      rows[eid][:transactions] = {} if rows[eid][:transactions].blank?
      rows[eid][:transactions][entry.transaction.transaction_type.code] = 0 if rows[eid][:transactions][entry.transaction.transaction_type.code].nil?
      rows[eid][:transactions][entry.transaction.transaction_type.code] = rows[eid][:transactions][entry.transaction.transaction_type.code] + entry.quantity
    end
    rows.compact
  end

  def inventory_only?
    COMPANY_MODE[subdomain.to_sym]
  end

  def create_default_transactions
    # untuk transaksi terima barang (BTB)
    TransactionType.new(:company_id => id,
                        :code => "AUTO-ITR",
                        :name => "Auto-generated from Item Receive",
                        :direction => 0,
                        :negate => false,
                        :alter_date => false,
                        :alter_stock => true,
                        :editable => false).save(false)
  end

  def create_default_warehouse
    warehouses.create(:code => 'Default', :name => 'Default warehouse', :default => true)
  end

  def create_defaults
    create_default_transactions
    create_default_warehouse
  end
end
