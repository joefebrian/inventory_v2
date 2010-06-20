class TaxProfile < ActiveRecord::Base
  attr_accessible :customer_id, :first_name, :last_name, :address, :postal_code, :npwp_number
  belongs_to :customer

  def full_name
    "#{first_name} #{last_name}"
  end
end
