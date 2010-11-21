class DeliveryOrder < ActiveRecord::Base
  attr_accessible :company_id, :customer_id, :customer_name, :sales_order_id, :number, :do_date, :reference, :description, :entries_attributes

  has_many :entries, :class_name => "DeliveryOrderEntry"
  belongs_to :customer
  belongs_to :sales_order
  belongs_to :company
  belongs_to :warehouse
  validates_presence_of :number, :customer_id, :do_date, :warehouse_id
  validates_uniqueness_of :number, :scope => :company_id

  def validate
    errors.add_to_base("Selected warehouse doesn't have sufficient stock for some or all of the items") if insuficient_stock?
  end

  def insuficient_items
    entries.reject do |entry|
      entry if warehouse.item_quantity(entry.plu) < entry.quantity
    end
  end

  def insuficient_stock?
    insuficient_items.blank?
  end

  after_save :close_so
  after_save :alter_stock

  def close_so
    if sales_order.all_entries_delivered?
      sales_order.closed = true
      sales_order.closing_note = "Closed automatically by Delivery Order # #{number}"
      sales_order.save!
    end
  end

  def alter_stock
    ttype = TransactionType.first(:conditions => { :company_id => company.id, :code => "AUTO-DO" })
    trans = company.general_transactions.new
    trans.transaction_type = ttype
    trans.number = GeneralTransaction.next_number(company, ttype)
    trans.origin_id = warehouse_id
    trans.alter_stock = true
    trans.remark = "Auto-generated from Delivery Order # #{number} date #{created_at.to_s(:long)}"
    entries.each do |entry|
      #plu = company.plus.first(:conditions => { :item_id => entry.item_id, :supplier_id => purchase_order.supplier_id })
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
    :reject_if => lambda {|a| a['quantity'].blank? }

  def after_initialize
    if new_record?
      self.warehouse_id = company.warehouses.default
      self.number = suggested_number
    end
  end

  def suggested_number
    last_number = company.delivery_orders.last.try(:number)
    next_available = last_number.nil? ? '00001' : sprintf('%05d', last_number.split('.').last.to_i + 1)
    time = Time.now
    prefix = "#{TRANS_PREFIX[:delivery_orders]}.#{time.strftime('%Y%m')}"
    "#{prefix}.#{next_available}"
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
        self.entries.build(:item_id => so_data.item_id, :quantity => so_data.quantity - (item_dos.nil? ? 0 : item_dos[1].to_i), :plu_id => so_data.plu_id) 
      end
    end
  end

  def before_save
    unless customer_id.blank?
    end
  end

  def customer_name
    customer.try(:profile).try(:full_name)
  end

  def customer_name=(name)
    first, last = name.split(' ', 2)
    customer = Company.find(company_id).customers.first(:joins => :profile, :conditions => { 'profiles.first_name' => first, 'profiles.last_name' => last })
  end

end
