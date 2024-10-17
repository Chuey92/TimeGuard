# app/policies/request_policy.rb

class RequestPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.manager?
        scope.all.includes(:user, :shift, :schedule)  # Managers see all requests
      else
        scope.where(user: user).includes(:shift, :schedule)  # Employees see their own requests
      end
    end
  end

  def create?
    true # Allow everyone to create requests (both managers and employees)
  end

  def update?
    user.manager? || record.user == user  # Managers can update any request; users can only update their own
  end

  def approve?
    user.manager?  # Only managers can approve requests
  end

  def reject?
    user.manager?  # Only managers can reject requests
  end

  def destroy?
    user.manager? || record.user == user  # Managers can delete any request; users can only delete their own
  end

  def show?
    user.manager? || record.user == user  # Managers can view any request; users can only view their own
  end

  def edit?
    user.manager? || record.user == user  # Managers can edit any request; users can only edit their own
  end
end
