class Project::Spk < ActiveRecord::Base
  include RecordNumberFormat

  record_number_format "SPK.#.#"
  belongs_to :company
  belongs_to :customer
  belongs_to :salesman

  has_many :materials, :class_name => "Project::Material::Spk"
  has_many :requests, :class_name => "Project::MaterialRequest"
  has_many :deliveries, :class_name => "Project::Delivery"
  
  accepts_nested_attributes_for :materials, :allow_destroy => true

  def customer_name=(name)
    first_name, last_name = name.split(/\s/, 2)
    cust = company.customers.first(:include => :profile, :conditions => { "profiles.first_name" => first_name, "profiles.last_name" => last_name })
    self.customer_id = cust.id if cust
  end

  def customer_name
    customer.try(:fullname)
  end
end
