class User < ActiveRecord::Base
  acts_as_authentic
  attr_accessible :username, :email, :password, :password_confirmation, :role
  belongs_to :company

  def role?(type)
    type.to_s == role
  end
end
