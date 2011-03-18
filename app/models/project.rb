class Project < ActiveRecord::Base
  attr_accessible :company_id, :number, :name, :customer_id, :description, :customer_name, :lot_materials_attributes, :materials_attributes, :spk_attributes
  belongs_to :customer
  belongs_to :company
  has_one :spk, :class_name => "ProjectWorkOrder"
  has_many :materials, :class_name => "ProjectMaterial"
  has_many :lot_materials
  has_many :material_requests
  has_many :work_orders

  validates_presence_of :number, :name, :customer_name
  accepts_nested_attributes_for :lot_materials, :allow_destroy => true, :reject_if => lambda { |att| att['title'].blank? || att['value'].blank? || att['value'].to_i <= 0 }
  accepts_nested_attributes_for :spk, :allow_destroy => true
  accepts_nested_attributes_for :materials, :allow_destroy => true, :reject_if => lambda { |att| att['title'].blank? || att['value'].blank? || att['value'].to_i <= 0 }
  accepts_nested_attributes_for :work_orders, :allow_destroy => true

  def customer_name
    customer.try(:fullname)
  end

  def customer_name=(name); end

  def after_initialize
    self.number = suggested_number if new_record?
  end

  def suggested_number
    last_number = company.projects.all(:order => :created_at).last.try(:number)
    last_number = "#{TRANS_PREFIX[:projects]}.#{Time.now.strftime('%Y%m')}.00000" unless last_number
    new_number(last_number)
  end

  def required_production_material?
    materials.detect { |m| m.item.assembly? }
  end
end
