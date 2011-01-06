class DirectSale < ActiveRecord::Base
  attr_accessible :company_id, :number, :tanggal, :customer_id, :salesman_id, :currency_id, :currency_rate, :top, :description, :entries_attributes
  belongs_to :company
  belongs_to :customer
  belongs_to :currency
  belongs_to :salesman
  has_many :entries, :class_name => "DirectSaleEntries"
  validates_presence_of :number, :currency_id, :currency_rate
  validates_uniqueness_of :number, :scope => :company_id

  def name
    number
  end

  def tgl_active
   tanggal = Chronic.parse(tanggal)
  end

  accepts_nested_attributes_for :entries,
    :allow_destroy => true,
    :reject_if => lambda {|a| a['quantity'].blank? }

  def after_initialize
    self.number = suggested_number if new_record?
  end

  def suggested_number
    last_number = company.direct_sales.all(:order => :created_at).last.try(:number)
    last_number = "#{TRANS_PREFIX[:direct_sales]}.#{Time.now.strftime('%Y%m')}.00000" unless last_number
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

  end

end
