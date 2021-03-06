class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
      # scope refers to what we put in policy_scope in restaurant_controller
    end
  end

  # def new?
  #   true # Anyone can create a restaurant
  # end

  def create?
    true
  end

  def update?
    # user and record are arguments of the initialize method of application policy
    # user == current_user, that's the way Pundit is built
    is_user_the_owner_or_admin?
  end

  def destroy?
    is_user_the_owner_or_admin?
  end

  private

  def is_user_the_owner_or_admin?
    record.user == user || user.admin?
  end
end
