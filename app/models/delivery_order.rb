class DeliveryOrder < ActiveRecord::Base
  attr_accessible :company_id, :customer_id, :customer_name, :sales_order_id, :number, :do_date, :reference, :description, :entries_attributes, :warehouse_id, :sales_invoice_id

  has_many :entries, :class_name => "DeliveryOrderEntry"
  belongs_to :customer
  belongs_to :sales_order
  has_and_belongs_to_many :sales_invoices
  belongs_to :company
  belongs_to :warehouse
  belongs_to :project
  validates_presence_of :number, :do_date, :warehouse_id
  validates_uniqueness_of :number, :scope => :company_id

  def validate
    #errors.add_to_base("Selected warehouse doesn't have sufficient stock for some or all of the items") if insuficient_stock?
  end

  def insuficient_items
    entries.reject do |entry|
      entry if warehouse.item_quantity(entry.plu) < entry.quantity
    end
  end

  def insuficient_stock?
    insuficient_items.blank?
  end

  before_save :sum_total_per_entries
  after_save :close_so
  after_save :alter_stock
  after_save :update_sales_order_delivered_quantity

  def update_sales_order_delivered_quantity
    sales_order.update_delivered
  end

  def close_so
    if sales_order.all_entries_delivered?
      sales_order.closed = true
      sales_order.closing_note = "Closed automatically by Delivery Order # #{number}"
      sales_order.save!
    end
  end

  def sum_total_per_entries
    entries.each do |entry|
      so_entry = sales_order.entries.first(:conditions => {:item_id => entry.item_id})
      price_per_entry = so_entry.total_price / so_entry.quantity
      entry.total_value = price_per_entry * entry.quantity
    end
  end

  def alter_stock
    ttype = TransactionType.first(:conditions => { :company_id => company.id, :code => "AUTO-DO" })
    trans = company.general_transactions.new
    trans.transaction_type = ttype
    trans.number = GeneralTransaction.next_number(company, ttype)
    trans.origin_id = warehouse_id
    trans.remark = "Auto-generated from Delivery Order # #{number} date #{created_at.to_s(:long)}"
    entries.each do |entry|
      trans.entries.build(:plu_id => entry.plu_id, :quantity => entry.quantity)
    end
    trans.save
  end

  def name
    number
  end

  def tgl_do_active
   do_date = Chronic.parse(date_do)
  end

  accepts_nested_attributes_for :entries,
    :allow_destroy => true,
    :reject_if => lambda {|a| a['quantity'].blank? || a['quantity'].to_i.zero? }

  def after_initialize
    if new_record?
      self.warehouse_id = company.warehouses.default
      self.number = suggested_number
    end
  end

  def suggested_number
    last_number = company.delivery_orders.all(:order => :created_at).last.try(:number)
    last_number = "#{TRANS_PREFIX[:delivery_orders]}.#{Time.now.strftime('%Y%m')}.00000" unless last_number
    new_number(last_number)
  end

  def build_entries_from_so
    entries.clear
    unless sales_order_id.blank?
      data_do = DeliveryOrder.all(:conditions => {:sales_order_id => sales_order_id}).collect{|d| d.id}
      item_do = DeliveryOrderEntry.calculate(:sum, 
                                             :quantity,
                                             :conditions => {:delivery_order_id => data_do},
                                             :group => :item_id)

      sales_order.entries.each do |so_data|
        item_dos = item_do.detect{|do_data1, do_data2| do_data1 == so_data.item_id.to_i}
        qty = so_data.quantity - (item_dos.nil? ? 0 : item_dos[1].to_i)
        self.entries.build(:item_id => so_data.item_id, :quantity => qty) 
      end
    end
  end

  def customer_name
    customer.try(:profile).try(:full_name)
  end

  def customer_name=(name)
    if name.present?
      first, last = name.split(' ', 2)
      tmp = Company.find(company_id).customers.first(:joins => :profile, :conditions => { 'profiles.first_name' => first, 'profiles.last_name' => last })
      self.customer_id = tmp.id
    end
  end

  def total_value
    entries.sum(:total_value)
  end
end
