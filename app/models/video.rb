class Video < ApplicationRecord
  searchkick
  scope :search_import, -> { includes(:review) }

  belongs_to :category
  has_many :reviews
  has_one :queue_item, dependent: :destroy

  mount_uploader :large_cover, LargeCoverUploader
  mount_uploader :small_cover, SmallCoverUploader

  validates_presence_of :title, :description

  def self.search_by_title(title)
    return [] if title.blank?
    where(["title ILIKE ?", "%#{title}%"])
  end

  def not_yet_queued?(user)
    !QueueItem.find_by(user_id: user.id, video_id: id)
  end

  def last_5_reviews
    reviews.order(updated_at: :desc).limit(5)
  end

  def average_review_score
    reviews&.average(:rating)&.round(1)
  end

  def search_data
    {
      title: title,
      description: description,
      average_score: reviews.average(:rating).to_f,
      reviews_count: reviews.count,
      review: {
        body: review.body
      }
    }
  end
end
