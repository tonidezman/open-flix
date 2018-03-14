class QueueItem < ApplicationRecord
  belongs_to :user
  belongs_to :video

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
end
