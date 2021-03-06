class QueueItem < ApplicationRecord
  belongs_to :user
  belongs_to :video

  validates :user, uniqueness: { scope: :video }
  validates :position, format: { with: /\A\d+\z/, message: "Integer only" }

  def self.normalize_positions(queue_items)
    queue_items.each_with_index do |queue_item, index|
      queue_item.position = index + 1
      queue_item.save!
    end
  end

  def save_rating(new_rating)
    if rating != new_rating
      review = Review.where(user: user, video: video).first
      review.rating = new_rating
      review.save!
    end
  end

  def create_new_rating(user_id, rating)
    review = Review.find_or_initialize_by(video_id: video.id, user_id: user_id)
    review.rating = rating
    review.save
  end

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
