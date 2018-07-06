# Class that outlines the relationship of between users via the User class
class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  # Validation for followers and following
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end