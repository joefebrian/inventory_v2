class Ability
  include CanCan::Ability

  def initialize(user)
    if user.roles? 'admin'
      can :manage, :all
    else
      user.roles.each do |role|
        role.privileges.each do |priv|
          can :manage, priv.resource.classify.constantize
        end
      end
    end
    can :read, Company
  end
end
