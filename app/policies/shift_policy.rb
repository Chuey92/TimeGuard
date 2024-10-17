class ShiftPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.manager?
        scope.all # Managers see all shifts
      else
        scope.where(user: user) # Employees see only their own shifts
      end
    end

    private

    attr_reader :user, :scope
  end

  def index?
    true
  end

  def create?
    user.manager?
  end

  def update?
    user.manager?
  end

  def destroy?
    user.manager?
  end

  def show?
    user.manager? || record.user == user
  end
end
