class Video < ApplicationRecord
  belongs_to :category
  has_many :reviews

  validates_presence_of :title, :description

  def self.search_by_title(title)
    return [] if title.blank?
    where(["title ILIKE ?", "%#{title}%"])
  end
end
