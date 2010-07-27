class SalesOrder < ActiveRecord::Base
  attr_accessible :company_id, :quotation_id, :number, :tanggal, :top, :advance, :status, :customer_id, :retensi, :kurs_id, :kurs_value, :order_ref
  has_many :entries, :class_name => "SalesOrderEntry"
  belongs_to :company
  belongs_to :assembly
  belongs_to :customer
  belongs_to :kurs_id
  belongs_to :kurs_rate
  validates_presence_of :number, :kurs_id, :kurs_rate
  validates_uniqueness_of :number, :scope => :company_id
  

  def tgl_active
   tanggal = Chronic.parse(tanggal_berlaku)
  end
  accepts_nested_attributes_for :entries, 
    :allow_destroy => true, 
    :reject_if => lambda {|a| a['quantity'].blank? }

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

  def before_save
    unless customer_id.blank?
    end
  end
end
