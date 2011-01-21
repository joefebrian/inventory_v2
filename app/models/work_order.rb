class WorkOrder < ActiveRecord::Base
  belongs_to :company
  has_many :entries, :class_name => "WorkOrderEntry", :dependent => :destroy
  has_many :completions, :class_name => "WorkOrderCompletion", :dependent => :destroy
  has_one :meterial_request

  validates_presence_of :number, :requester
  validates_uniqueness_of :number, :scope => :company_id

  accepts_nested_attributes_for :entries, :allow_destroy => true, :reject_if => lambda { |at| at['quantity'].blank? || at['quantity'].to_i <= 0 }
  accepts_nested_attributes_for :completions, :allow_destroy => true, :reject_if => lambda { |at| at['quantity'].blank? || at['quantity'].to_i <= 0 }
  after_create :generate_production_material_request

  def after_initialize
    self.number = suggested_number if new_record?
  end

  def suggested_number
    last_number = company.work_orders.all(:order => :created_at).last.try(:number)
    last_number = "#{TRANS_PREFIX[:work_orders]}.#{Time.now.strftime('%Y%m')}.00000" unless last_number
    new_number(last_number)
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
