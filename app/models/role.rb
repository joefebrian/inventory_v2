class Role < ActiveRecord::Base
  attr_accessible :name, :company_id
  belongs_to :company
  has_and_belongs_to_many :users
end
