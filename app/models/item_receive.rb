class ItemReceive < ActiveRecord::Base
  attr_accessible :purchase_order_id, :number, :user_date, :remark, :warehouse_id, :entries_attributes
  belongs_to :company
  belongs_to :purchase_order
  belongs_to :warehouse
  has_many :entries, :class_name => "ItemReceiveEntry", :dependent => :destroy

  validates_presence_of :number
  validates_presence_of :user_date
  validates_presence_of :purchase_order_id
  validates_presence_of :warehouse_id

  after_save :close_purchase_order
  after_save :alter_stock

  accepts_nested_attributes_for :entries,
    :allow_destroy => true,
    :reject_if => lambda { |att| att['item_id'].blank? || att['quantity'].blank? }

  def validate
    errors.add_to_base('Transaction items cannot be empty') if entries.blank?
  end

  def after_initialize
    if new_record?
      self.number = suggested_number
      self.warehouse_id = company.default_warehouse.id if warehouse_id.blank?
      self.user_date = Time.now.strftime("%m/%d/%Y") if user_date.blank?
    end
  end

  def suggested_number
    last_number = company.item_receives.last.try(:number)
    next_available = last_number.nil? ? '00001' : sprintf('%05d', last_number.split('.').last.to_i + 1)
    time = Time.now
    prefix = "#{TRANS_PREFIX[:item_receives]}.#{time.strftime('%Y%m')}"
    "#{prefix}.#{next_available}"
  end

  def build_entries_from_po
    entries.clear
    po_entries = PurchaseOrderEntry.all(:conditions => { :purchase_order_id => purchase_order_id }, :group => :item_id)
    po_entries.each do |entry|
      self.entries.build(:item_id => entry.item.id, :quantity => entry.purchase_order.quantity_left(entry.item))
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
    trans = GeneralTransaction.new
    trans.transaction_type = ttype
    trans.number = GeneralTransaction.next_number(company, ttype)
    trans.destination_id = warehouse_id
    trans.alter_stock = true
    trans.remark = "Auto-generated from Item Receive # #{number} date #{created_at.to_s(:long)}"
    entries.each do |entry|
      plu = company.plus.first(:conditions => { :item_id => entry.item_id, :supplier_id => purchase_order.supplier_id })
      trans.entries.build(:plu_id => plu.id, :quantity => entry.quantity)
    end
    trans.save
  end
end
