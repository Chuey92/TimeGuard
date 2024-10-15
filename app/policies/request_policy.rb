class RequestPolicy < ApplicationPolicy
  def create?
    user.employee?
  end

  def update?
    user.manager? || record.user == user
  end

  def approve?
    user.manager?
  end

  def reject?
    user.manager?
  end
end
