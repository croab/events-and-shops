class ShopPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    true
    # user.admin?
    # record.user == user
  end

  def update?
    is_shop_admin? || user.role.admin?
  end

  def destroy?
    is_shop_admin? || user.role.admin?
  end

  private

  def is_shop_admin?
    record.shop_admins.exists?(user: user)
  end
end
