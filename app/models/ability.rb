class Ability
  include CanCan::Ability

  def initialize(user)
    user ? user_rules(user) : nil
  end

  def user_rules(user)
    user.roles.each do |role|
      send("#{role}_rules", user) if respond_to?("#{role}_rules")
    end
  end

  def admin_rules(user)
    can :manage, :all
    can :assign_roles, User
    can :edit_profile, User
    can :update_profile, User
  end

  def regular_rules(user)
    can :manage, Sample
    can :manage, [Shift, Essay], { user_id: user.id }
    can :read, Client
    can :create, Client
    can :edit_profile, User
    can :update_profile, User
  end
end
