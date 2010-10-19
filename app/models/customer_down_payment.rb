class CustomerDownPayment < ActiveRecord::Base
  attr_accessible :company_id, :customer_id, :number, :value, :tanggal, :description, :customer_name
  belongs_to :customer
  belongs_to :company
  validates_presence_of :number, :customer_id, :tanggal
  validates_uniqueness_of :number, :scope => :company_id

  def name
    number
  end

  def tgl_do_active
   tanggal = Chronic.parse(tanggal)
  end

  def after_initialize
    self.number = suggested_number if new_record?
  end

  def suggested_number
    last_number = company.customer_down_payments.last.try(:number)
    next_available = last_number.nil? ? '00001' : sprintf('%05d', last_number.split('.').last.to_i + 1)
    time = Time.now
    prefix = "#{TRANS_PREFIX[:customer_down_payments]}.#{time.strftime('%Y%m')}"
    "#{prefix}.#{next_available}"
  end
  def before_save
    unless customer_id.blank?
    end
  end

  def customer_name
    customer.try(:profile).try(:full_name)
  end

  def customer_name=(name)

  end

end
