class DeliveryOrder < ActiveRecord::Base
  attr_accessible :company_id, :customer_id, :sales_order_id, :number, :do_date, :reference, :description, :entries_attributes

  has_many :entries, :class_name => "DeliveryOrderEntry"
  has_many :customers
  has_many :sales_orders
  belongs_to :company
  validates_presence_of :number, :customer_id, :do_date
  validates_uniqueness_of :number, :scope => :company_id
  
  def name
    number
  end

  def creat_date
   do_date = Chronic.parse(date)
  end

  accepts_nested_attributes_for :entries, 
    :allow_destroy => true, 
    :reject_if => lambda {|a| a['quantity'].blank? }

  def after_initialize
    self.number = suggested_number if new_record?
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
      items = SalesOrderEntry.calculate(:sum,
                                             :quantity,
                                             :conditions => { :sales_order_id => sales_order_id },
                                             :group => :item_id)
      items.each do |item_id, qty|
        self.entries.build(:item_id => item_id,
                           :quantity => qty)
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
