class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.validations_scope = :company_id
  end
  attr_accessible :username, :email, :password, :password_confirmation, :role_ids, :company_id
  belongs_to :company
  has_and_belongs_to_many :roles
  
  validates_uniqueness_of :username, :scope => :company_id

  def roles?(type)
    roles.collect { |role| role.name }.include? type.to_s
  end
end
