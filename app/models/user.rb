class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[yandex github]

  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  has_one_attached :avatar do |attachable|
    attachable.variant :default, resize_to_fill: [200, 200]
    attachable.variant :thumb, resize_to_fill: [70, 70]
  end

  validates :name, presence: true, length: { maximum: 35 }

  after_commit :link_subscriptions, on: :create

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  class << self
    def find_for_gh_oauth(access_token)
      standart_oauth(access_token)
    end

    def self.find_for_ya_oauth(access_token)
      standart_oauth(access_token)
    end

      private

    def standart_oauth(access_token)
      email = access_token.info.email

      user = where(email:).first
      return user if user.present?

      provider = access_token.provider
      provider_id = access_token.extra.raw_info.id
      name = access_token.info.name

      where(provider_id:, provider:).first_or_create! do |user|
        user.name = name
        user.email = email
        user.password = Devise.friendly_token.first(16)
      end
    end
    end

  def self.find_for_gh_oauth(access_token)
    standart_oauth(access_token)
  end

  def self.find_for_ya_oauth(access_token)
    standart_oauth(access_token)
  end

  private

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: email).update_all(user_id: id)
  end
end
