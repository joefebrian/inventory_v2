class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role?:admin
    end
  end
end
