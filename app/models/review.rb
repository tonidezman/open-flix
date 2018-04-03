class Review < ApplicationRecord
  belongs_to :user
  belongs_to :video, touch: true

  after_save :reindex_videos

  def video_category
    video.category
  end

  def video_category_name
    video.category.name
  end

  def reindex_videos
    Video.reindex
  end
end
