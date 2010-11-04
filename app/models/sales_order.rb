class SalesOrder < ActiveRecord::Base
  attr_accessible :company_id, :quotation_id, :number, :tanggal, :top, :advance, :status, :customer_id, :retensi, :currency_id, :currency_rate, :order_ref, :salesman_id, :entries_attributes, :customer_name
  has_many :entries, :class_name => "SalesOrderEntry"
  belongs_to :company
  belongs_to :assembly
  belongs_to :customer
  belongs_to :currency
  belongs_to :quotation
  belongs_to :salesman
  validates_presence_of :number, :currency_id, :currency_rate
  validates_uniqueness_of :number, :scope => :company_id

  named_scope :all_closed, :conditions => { :closed => true }
  named_scope :all_open, :conditions => { :closed => false }

  accepts_nested_attributes_for :entries,
    :allow_destroy => true,
    :reject_if => lambda {|at| at['quantity'].blank? || at['quantity'].to_i == 0}

  def tgl_active
   tanggal = Chronic.parse(tanggal_berlaku)
  end

  def after_initialize
    self.number = suggested_number if new_record?
  end

  def suggested_number
    last_number = company.sales_orders.last.try(:number)
    next_available = last_number.nil? ? '00001' : sprintf('%05d', last_number.split('.').last.to_i + 1)
    time = Time.now
    prefix = "#{TRANS_PREFIX[:sales_order]}.#{time.strftime('%Y%m')}"
    "#{prefix}.#{next_available}"
  end

  def build_entries_from_quot
    entries.clear
    unless quotation.blank?
      items = QuotationEntry.all(:conditions => { :quotation_id => quotation_id },
                                 :group => :item_id)
      items.each do |entry|
        self.entries.build(:item_id => entry.item_id,
                           :quantity => entry.quantity,
                           :price => entry.price,
                           :diskon => entry.discount,
                           :total_price => entry.total_price)
      end
    end
  end

  def name
    number
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
