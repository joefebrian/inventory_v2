class Project < ActiveRecord::Base
  attr_accessible :company_id, :number, :name, :customer_id, :description, :customer_name, :lot_items_attributes, :material_request_attributes
  belongs_to :customer
  belongs_to :company
  has_one :material_request
  has_many :lot_items

  after_create :create_materials_list

  validates_presence_of :number, :name, :customer_name
  accepts_nested_attributes_for :material_request, :allow_destroy => true
  accepts_nested_attributes_for :lot_items, :allow_destroy => true, :reject_if => lambda { |att| att['title'].blank? || att['value'].blank? || att['value'].to_i <= 0 }

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

  def create_materials_list
    mr = MaterialRequest.new(:company_id => company_id, :userdate => Time.now.to_date, :description => "Materials for project # #{number}")
    mr.project_id = id
    mr.number = nil
    mr.save(false)
  end
end
