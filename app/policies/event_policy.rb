class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all if user.present?
    end
  end

  def show?
    pincode_guard!(record)
  end

  def new?
    user.present?
  end

  def edit?
    update?
  end

  def create?
    new?
  end

  def update?
    user_is_owner?(@record)
  end

  def destroy?
    update?
  end

  private

  def user_is_owner?(event)
    user.present? && (event.try(:user) == user)
  end

  def pincode_guard!(event_context)
    return true if event_context.event.pincode.blank? || user_is_owner?(event_context.event)

    event_context.pincode.present? && event_context.event.pincode_valid?(event_context.pincode)
  end
end
