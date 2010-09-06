class SalesInvoice < ActiveRecord::Base
  attr_accessible :company_id, :delivery_order_id, :number, :ppn, :due_date, :top
  belongs_to :delivery_order
  belongs_to :company
  validates_presence_of :number
  validates_uniqueness_of :number, :scope => :company_id

  def nama
    number
  end
  
  def after_initialize
    self.number = suggested_number if new_record?
  end

  def suggested_number
    last_number = company.sales_invoices.last.try(:number)
    next_available = last_number.nil? ? '00001' : sprintf('%05d', last_number.split('.').last.to_i + 1)
    time = Time.now
    prefix = "#{TRANS_PREFIX[:sales_invoices]}.#{time.strftime('%Y%m')}"
    "#{prefix}.#{next_available}"
  end

  def tgl_active
   date = Chronic.parse(due_date)
  end


end
