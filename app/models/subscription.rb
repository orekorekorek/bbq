class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, unless: -> { user.present? }

  validates :user, uniqueness: { scope: :event_id }, if: -> { user.present? }
  validate :not_organizer

  validates :user_email, uniqueness: { scope: :event_id }, unless: -> { user.present? }
  validate :user_already_exist, unless: -> { user.present? }

  def user_name
    user.present? ? user.name : super
  end

  def user_email
    user.present? ? user.email : super
  end

  def not_organizer
    errors.add(:user, I18n.t('subscriptions.subscription.errors.owner_cant_be_subscriber')) if user == event.user
  end

  def user_already_exist
    if User.find_by(email: user_email).present?
      errors.add(:user_email, I18n.t('subscriptions.subscription.errors.user_already_exist'))
    end
  end
end
