class NotifySubscribersJob < ApplicationJob
  queue_as :default

  def perform(record)
    event = record.event
    all_emails = (event.subscriptions.map(&:user_email) + [event.user.email] - [photo.user&.email]).uniq

    case record
    when Photo
      all_emails.each { |mail| EventMailer.photo(record, mail).deliver_later }
    when Comment
      all_emails.each { |mail| EventMailer.comment(record, mail).deliver_later }
    end
  end
end
