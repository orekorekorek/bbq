class NotifySubscribersJob < ApplicationJob
  queue_as :default

  def perform(record)
    event = record.event
    all_emails = (event.subscriptions.map(&:user_email) + [event.user.email] - [record.user&.email]).uniq

    case record
    when Photo
      EventMailer.photo(record, all_emails).deliver_later
    when Comment
      EventMailer.comment(record, all_emails).deliver_later
    end
  end
end
