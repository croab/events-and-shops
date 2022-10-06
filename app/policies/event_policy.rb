class EventPolicy < ApplicationPolicy
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
    record.user == user
  end

  def destroy?
    record.user == user
  end
end
