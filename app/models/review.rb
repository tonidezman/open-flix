class Review < ApplicationRecord
  searchkick

  belongs_to :user
  belongs_to :video

  validates :rating, presence: true

  def video_category
    video.category
  end

  def video_category_name
    video.category.name
  end

  def search_data
    {
      body: body,
    }
  end
end
