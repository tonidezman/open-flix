class Review < ApplicationRecord
  belongs_to :user
  belongs_to :video

  validates :rating, presence: true
end
