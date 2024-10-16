class RequestPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if @user.manager?
        @scope.all # Managers can see all requests
      else
        @scope.where(user: @user) # Employees can only see their own requests
      end
    end
  end

  def create?
    @user.employee?
  end

  def update?
    @user.manager? || record.user == @user
  end

  def approve?
    @user.manager?
  end

  def reject?
    @user.manager?
  end
end
