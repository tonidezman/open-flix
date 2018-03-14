class Video < ApplicationRecord
  belongs_to :category
  has_many :reviews
  has_many :queue_items, dependent: :destroy

  validates_presence_of :title, :description

  def self.search_by_title(title)
    return [] if title.blank?
    where(["title ILIKE ?", "%#{title}%"])
  end

  def last_5_reviews
    reviews.order(updated_at: :desc).limit(5)
  end

  def average_review_score
    reviews&.average(:rating)&.round(1)
  end
end
