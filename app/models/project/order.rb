class Project::Order < ActiveRecord::Base
  include RecordNumberFormat
  record_number_format "SPK.#.#"
  belongs_to :company
  belongs_to :customer
  validates_presence_of :name
  validates_presence_of :customer_name
  validates_presence_of :payment_terms

  def customer_name=(name)
    #first, last = name.split(/\s/, 2)
    #cid = Customer.first(:include => :profile, :conditions => { "profiles.first_name" => first, "profiles.last_name" => last, :company_id => company_id})
    #self.customer_id = cid.id if cid
  end

  def customer_name
    customer.try(:fullname)
  end

end
