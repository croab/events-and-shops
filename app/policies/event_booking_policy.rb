class EventBookingPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def create?
    true
  end

  def destroy?
    record.user == user || user.is_site_admin?
  end
end
