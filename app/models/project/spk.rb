class Project::Spk < ActiveRecord::Base
  include RecordNumberFormat

  record_number_format "SPK.#.#"
  belongs_to :company
  belongs_to :customer
  belongs_to :salesman

  has_many :main_materials, :class_name => "Project::Material::Main"
  has_many :secondary_materials, :class_name => "Project::Material::Secondary"
  has_many :requests, :class_name => "Project::MaterialRequest"
  has_many :deliveries, :class_name => "Project::Delivery"
  
  accepts_nested_attributes_for :main_materials, :allow_destroy => true, :reject_if => lambda {|att| att['price'].blank? || att['quantity'].blank? }
  accepts_nested_attributes_for :secondary_materials, :allow_destroy => true, :reject_if => lambda {|att| att['price'].blank? }
  validates_presence_of :name
  validates_presence_of :customer_id

  def customer_name=(name)
    first_name, last_name = name.split(/\s/, 2)
    cust = company.customers.first(:include => :profile, :conditions => { "profiles.first_name" => first_name, "profiles.last_name" => last_name })
    self.customer_id = cust.id if cust
  end

  def customer_name
    customer.try(:fullname)
  end

  def gross_total
    main_total = main_materials.map(&:total_value).sum
    secondary_total = secondary_materials.map(&:price).sum
    main_total + secondary_total
  end

  def net_total
    discounted_value = discount.nil? ? 0 : (gross_total * discount) / 100.0
    gross_total - discounted_value - (rounding || 0)
  end
end

