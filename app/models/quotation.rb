class Quotation < ActiveRecord::Base
  attr_accessible :company_id,
    :number,
    :tanggal_berlaku,
    :customer_id,
    :day,
    :hal,
    :penerima,
    :nama_proyek_customer,
    :keterangan,
    :customer_name,
    :entries_attributes
  has_many :entries, :class_name => "QuotationEntry"
  belongs_to :company
  belongs_to :customer
  validates_presence_of :number
  validates_uniqueness_of :number, :scope => :company_id

  def validate
    errors.add_to_base("Customer name cannot be empty") if customer_name.blank?
    errors.add_to_base("Quotation items cannot be empty") if entries.blank?
  end
  
  def name
    number
  end

  def tgl_active
   tanggal_berlaku = Chronic.parse(tanggal_berlaku)
  end
  accepts_nested_attributes_for :entries, 
    :allow_destroy => true, 
    :reject_if => lambda {|a| a['quantity'].blank? }

  def after_initialize
    self.number = suggested_number if new_record?
  end

  def suggested_number
    last_number = company.quotations.last.try(:number)
    last_number = "#{TRANS_PREFIX[:quotation]}.#{time.strftime('%Y%m')}.00000" unless last_number
    new_number(last_number)
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
