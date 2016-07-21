class Ability
  include CanCan::Ability

  def initialize(user)
    # TODO
    if user.admin?
      can :manage, :all
    else
      can :read, :all
    end

  end
end
