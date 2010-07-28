class Supplier < ActiveRecord::Base
  attr_accessible :company_id, :code, :name, :description, :profile_attributes, :email
  belongs_to :company
  belongs_to :profile
  has_and_belongs_to_many :quotation_requests
  has_many :purchase_orders
  validates_presence_of :code, :message => "code can't be blank"
  validates_presence_of :name, :message => "name can't be blank"
  validates_uniqueness_of :code, :scope => :company_id

  accepts_nested_attributes_for :profile

  def address
    profile.address
  end
end
