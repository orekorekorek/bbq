class EventContext
  attr_reader :event, :pincode

  def initialize(event:, pincode: nil)
    @event = event
    @pincode = pincode
  end
end
