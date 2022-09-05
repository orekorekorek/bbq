class Photo < ApplicationRecord
  belongs_to :user
  belongs_to :event

  has_one_attached :photo

  scope :persisted, -> { where 'id IS NOT NULL' }

  validates :photo, presence: true
end
