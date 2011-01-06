class SalesReturn < ActiveRecord::Base
  attr_accessible :company_id, :number, :tanggal, :customer_id, :customer_name, :description, :entries_attributes

  has_many :entries, :class_name => "SalesReturnEntry"
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

  accepts_nested_attributes_for :entries,
    :allow_destroy => true,
    :reject_if => lambda {|a| a['quantity'].blank? }

  def after_initialize
    self.number = suggested_number if new_record?
  end

  def suggested_number
    last_number = company.sales_returns.all(:order => :created_at).last.try(:number)
    last_number = "#{TRANS_PREFIX[:sales_returns]}.#{time.strftime('%Y%m')}.00000" unless last_number
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
