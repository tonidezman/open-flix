class Video < ApplicationRecord
  belongs_to :category

  validates_presence_of :title, :description

  scope :search_by_title, ->(title) { where(["title ILIKE ?", "%#{title}%"]) }
end
