class QueueItem < ApplicationRecord
  belongs_to :user
  belongs_to :video

  validates :user_id, uniqueness: { scope: :video_id }
  validates :position, format: { with: /\A\d+\z/, message: "Integer only" }

  def video_title
    video.title
  end

  def rating
    default_value = 0
    Review.where(user: user, video: video).first&.rating || default_value
  end

  def category_name
    video.category.name
  end

  def category
    video.category
  end

  def is_valid_number(str)
    if !/\A\d+\z/.match(str)
      raise ArgumentError.new("Only integers allowed.")
    end
  end
end
