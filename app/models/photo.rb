class Photo < ApplicationRecord
  belongs_to :user
  belongs_to :event

  has_one_attached :photo do |attachable|
    attachable.variant :medium, resize_to_fit: [300, 300]
    attachable.variant :thumb, resize_to_fit: [100, 100]
  end

  scope :persisted, -> { where 'id IS NOT NULL' }

  validates :photo, presence: true
end
