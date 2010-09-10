class QuotationRequest < ActiveRecord::Base
  belongs_to :company
  has_many :entries, :class_name => "QuotationRequestEntry"
  has_and_belongs_to_many :suppliers
  validates_presence_of :number
  validates_presence_of :request_date
  validates_uniqueness_of :number, :scope => :company_id

  accepts_nested_attributes_for :entries,
    :allow_destroy => true,
    :reject_if => lambda { |att| att['item_id'].empty? }

  def after_initialize
    self.number = suggested_number if new_record?
    self.request_date = Time.now.strftime("%d/%m/%Y") if self.request_date.blank?
  end

  def suggested_number
    last_number = company.quotation_requests.last.try(:number)
    next_available = last_number.nil? ? '00001' : sprintf('%05d', last_number.split('.').last.to_i + 1)
    time = Time.now
    prefix = "#{TRANS_PREFIX[:quotation_request]}.#{time.strftime('%Y%m')}"
    "#{prefix}.#{next_available}"
  end
end
