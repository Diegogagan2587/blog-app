class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.is? :user
      can :manage, Post, author_id: user.id
      can :manage, Comment
    elsif user.is? :admin
      can :manage, :all
    end
  end
end
