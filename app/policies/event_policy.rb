class EventPolicy < ApplicationPolicy
  def update?
    user_is_owner?(@record)
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  def show?
    pincode_guard!(record)
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
