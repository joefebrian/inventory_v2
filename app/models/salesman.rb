class Salesman < ActiveRecord::Base
  attr_accessible :company_id, :profile_id, :code, :profile_attributes
  belongs_to :profile
  belongs_to :company
  has_many :sales_orders
  
  validates_presence_of :code
  validates_uniqueness_of :code, :scope => :company_id  
  accepts_nested_attributes_for :profile
  
  def to_s
    profile.full_name
  end

  def fullname
    profile.full_name
  end
  
end
