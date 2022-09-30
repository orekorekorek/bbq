class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all if user.present?
    end
  end

  def show?
    pincode_guard!
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
    user_is_owner?
  end

  def destroy?
    update?
  end

  private

  def user_is_owner?
    @user.present? && (@record.user == @user)
  end

  def pincode_guard!
    return true if @record.event.pincode.blank? || user_is_owner?

    @record.pincode.present? && @record.event.pincode_valid?(@record.pincode)
  end
end
