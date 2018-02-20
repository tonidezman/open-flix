class Category < ApplicationRecord
  has_many :videos, -> { order :title }, dependent: :destroy

  scope :all_asc, -> { all.order(name: :asc) }

  validates :name, presence: true

  def recent_videos
    upper_bound = 6
    Video.where(category: self).order(updated_at: :desc).limit(upper_bound)
  end
end
