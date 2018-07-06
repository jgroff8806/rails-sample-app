# Class that outlines the Micropost data stored in the DB
# Utilizes local file upload for picture files
# Validation of the user id, content and size of picture uploaded
class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate  :picture_size

  private

    # Validates the size of an uploaded picture
    # If the picture is > 5 MB, error prompt is displayed
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end