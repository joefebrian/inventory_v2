class MaterialRequest < ActiveRecord::Base
  attr_accessible :company_id, :number, :userdate, :reference, :requester, :description, :entries_attributes
  belongs_to :company
  has_many :entries, :class_name => "MaterialRequestEntry"
  has_many :trackers, :class_name => "PoMrTracker"
  has_and_belongs_to_many :purchase_orders

  validates_presence_of :number, :userdate, :reference, :requester
  validates_uniqueness_of :number, :scope => :company_id

  accepts_nested_attributes_for :entries,
    :allow_destroy => true,
    :reject_if => lambda { |att| att['item_id'].blank? || att['quantity'].blank? }

  def after_initialize
    self.number = suggested_number if new_record?
    self.userdate = Time.now.to_s(:long) if new_record?
  end

  def suggested_number
    last_number = company.material_requests.last.try(:number)
    next_available = last_number.nil? ? '00001' : sprintf('%05d', last_number.split('.').last.to_i + 1)
    time = Time.now
    prefix = "#{TRANS_PREFIX[:material_request]}.#{time.strftime('%Y%m')}"
    "#{prefix}.#{next_available}"
  end

  def name
    number
  end

end
