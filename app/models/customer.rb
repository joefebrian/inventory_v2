class Customer < ActiveRecord::Base
  attr_accessible :profile_id, :code, :profile_attributes, :tax_profile_attributes
  belongs_to :company
  belongs_to :profile
  has_one :tax_profile

  validates_presence_of :code
  validates_uniqueness_of :code, :scope => :company_id
  accepts_nested_attributes_for :profile
  accepts_nested_attributes_for :tax_profile
end
