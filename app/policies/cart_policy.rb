class CartPolicy < ApplicationPolicy
  class Scope < Scope
    # def resolve
    #   scope.all
    # end
  end

  def show?
    true
  end

  def add?
    true
  end

  def remove?
    true
  end
end
