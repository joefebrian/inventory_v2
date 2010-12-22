class WorkOrder < ActiveRecord::Base
  belongs_to :company
  has_many :entries, :class_name => "WorkOrderEntry", :dependent => :destroy

  validates_presence_of :number, :requester
  validates_uniqueness_of :number, :scope => :company_id

  accepts_nested_attributes_for :entries, :allow_destroy => true, :reject_if => lambda { |at| at['quantity'].blank? || at['quantity'].to_i <= 0 }

  def after_initialize
    self.number = suggested_number if new_record?
  end

  def suggested_number
    last_number = company.work_orders.last.try(:number)
    next_available = last_number.nil? ? '00001' : sprintf('%05d', last_number.split('.').last.to_i + 1)
    time = Time.now
    prefix = "#{TRANS_PREFIX[:work_orders]}.#{time.strftime('%Y%m')}"
    "#{prefix}.#{next_available}"
  end

end
