class EventBookingPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def create?
    true
  end

  def destroy?
    record.user == user || user.role.admin?
  end
end
