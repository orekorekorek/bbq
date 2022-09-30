class EventContext
  attr_reader :event, :user, :pincode

  def initialize(event:, user:, pincode: nil)
    @event = event
    @user = user
    @pincode = pincode
  end
end
