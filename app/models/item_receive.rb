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

  accepts_nested_attributes_for :entries,
    :allow_destroy => true,
    :reject_if => lambda { |att| att['item_id'].blank? || att['quantity'].blank? }

  def after_initialize
    self.number = suggested_number if new_record?
    self.user_date = Time.now.strftime("%d/%m/%Y") if self.user_date.blank?
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

  def close_purchase_order
    purchase_order.close
  end

end