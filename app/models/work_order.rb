class WorkOrder < ActiveRecord::Base
  belongs_to :company
  has_many :entries, :class_name => "WorkOrderEntry", :dependent => :destroy

  validates_presence_of :number, :requester
  validates_uniqueness_of :number, :scope => :company_id

  accepts_nested_attributes_for :entries, :allow_destroy => true, :reject_if => lambda { |at| at['quantity'].blank? || at['quantity'].to_i <= 0 }
  after_save :generate_production_material_request

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

  def generate_production_material_request
    required_materials = {}
    entries.each do |e|
      a = e.required_materials
      a.each do |k,v|
        if required_materials[k]
          required_materials[k] = required_materials[k] + v
        else
          required_materials[k] = v
        end
      end
    end
    mr = company.material_requests.productions.new
    mr.description = "Materials required for Work Order # #{number}"
    mr.work_order_id = id
    required_materials.each do |k, v|
      mr.entries.build(:item_id => k.to_i, :quantity => v)
    end
    mr.save(false)
  end
end
