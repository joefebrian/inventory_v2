class User < ActiveRecord::Base
  acts_as_authentic
  attr_accessible :username, :email, :password, :password_confirmation, :role
  belongs_to :company
  has_and_belongs_to_many :roles

  def roles?(type)
    roles.collect { |role| role.name }.include? type.to_s
  end
end
