# frozen_string_literal:true

class TaskPolicy < ApplicationPolicy
  def update?
    !record.finished?
  end

  def edit?
    !record.finished?
  end

  def destroy?
    !record.finished?
  end
end
