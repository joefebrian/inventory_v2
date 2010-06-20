class Profile < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :address, :city, :phone, :fax
  has_one :customer

  def full_name
    "#{first_name} #{last_name}"
  end
end
