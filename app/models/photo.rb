class Photo < ApplicationRecord
  belongs_to :user
  belongs_to :event

  mount_uploader :photo, PhotoUploader

  scope :persisted, -> { where 'id IS NOT NULL' }
end
