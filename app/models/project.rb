class Project < ActiveRecord::Base
  attr_accessible :company_id, :number, :name, :customer_id, :description, :customer_name, :lot_items_attributes, :materials_attributes, :work_order_attributes
  belongs_to :customer
  belongs_to :company
  has_one :work_order, :class_name => "ProjectWorkOrder"
  has_many :lot_items
  has_many :materials, :class_name => "ProjectMaterial"
  has_many :material_requests

  validates_presence_of :number, :name, :customer_name
  accepts_nested_attributes_for :lot_items, :allow_destroy => true, :reject_if => lambda { |att| att['title'].blank? || att['value'].blank? || att['value'].to_i <= 0 }
  accepts_nested_attributes_for :work_order, :allow_destroy => true
  accepts_nested_attributes_for :materials, :allow_destroy => true, :reject_if => lambda { |att| att['title'].blank? || att['value'].blank? || att['value'].to_i <= 0 }

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
end
