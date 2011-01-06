class ItemReceive < ActiveRecord::Base
  attr_accessible :purchase_order_id, :number, :user_date, :remark, :warehouse_id, :entries_attributes
  belongs_to :company
  belongs_to :purchase_order
  belongs_to :warehouse
  has_many :entries, :class_name => "ItemReceiveEntry", :dependent => :destroy
  has_and_belongs_to_many :invoices, :join_table => "invoices_item_receives"
  has_many :suppliers, :through => :purchase_order
  
  validates_presence_of :number
  validates_presence_of :user_date
  validates_presence_of :purchase_order_id
  validates_presence_of :warehouse_id

  after_save :close_purchase_order
  after_update :confirmed_and_alter_stock

  accepts_nested_attributes_for :entries,
    :allow_destroy => true,
    :reject_if => lambda { |att| att['item_id'].blank? || att['quantity'].blank? }

  def validate
    errors.add_to_base('Transaction items cannot be empty') if entries.blank?
  end

  named_scope :unconfirmed, :conditions => { :confirmed => false }
  named_scope :all_confirmed, :conditions => { :confirmed => true }

  def after_initialize
    if new_record?
      self.number = suggested_number
      self.warehouse_id = company.default_warehouse.id if warehouse_id.blank?
      self.user_date = Time.now.strftime("%m/%d/%Y") if user_date.blank?
    end
  end

  def suggested_number
    last_number = company.item_receives.all(:order => :created_at).last.try(:number)
    last_number = "#{TRANS_PREFIX[:item_receives]}.#{Time.now.strftime('%Y%m')}.00000" unless last_number
    new_number(last_number)
  end

  def build_entries_from_po
    entries.clear
    po_entries = PurchaseOrderEntry.all(:conditions => { :purchase_order_id => purchase_order_id }, :group => :item_id)
    po_entries.each do |entry|
      self.entries.build(:item_id => entry.item.id, :quantity => entry.purchase_order.quantity_left(entry.item)) if entry.purchase_order.quantity_left(entry.item) > 0
    end
  end

  def check_plu
    purchase_order.entries_plu_satisfied?    
  end

  def close_purchase_order
    purchase_order.close
  end

  def alter_stock
    ttype = TransactionType.first(:conditions => { :company_id => company.id, :code => "AUTO-ITR" })
    trans = company.general_transactions.new
    trans.transaction_type = ttype
    trans.number = GeneralTransaction.next_number(company, ttype)
    trans.destination_id = warehouse_id
    trans.remark = "Auto-generated from Item Receive # #{number} date #{created_at.to_s(:long)}"
    trans.save
    entries.each do |entry|
      plu = company.plus.first(:conditions => { :item_id => entry.item_id, :supplier_id => purchase_order.supplier_id })
      trans.entries.create(:plu_id => plu.id, :quantity => entry.quantity)
    end
  end

  def confirmed_and_alter_stock
    if confirmed?
      alter_stock
    end
  end

  def create_invoice
    invoice = company.invoices.new
    invoice.item_receives << self
    invoice.remark = "Auto-generated invoice"
    while !invoice.save
      invoice = company.invoices.new
      invoice.item_receives << self
      invoice.remark = "Auto-generated invoice"
    end
  end

  def to_s
    number
  end

  def total_po
    purchase_order.total_value
  end

  def populate_total
    self.total = entries.collect { |e| e.total }.sum
    save
  end

  def auto_confirm
    self.confirmed = true
    self.total = entries.collect { |e| e.total }.sum
    save
  end
end
