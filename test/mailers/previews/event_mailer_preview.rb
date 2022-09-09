# Preview all emails at http://localhost:3000/rails/mailers/event_mailer
class EventMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/event_mailer/subscription
  def subscription
    EventMailer.subscription
  end

  # Preview this email at http://localhost:3000/rails/mailers/event_mailer/comment
  def comment
    EventMailer.comment
  end

end
