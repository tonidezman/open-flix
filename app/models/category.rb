class Category < ApplicationRecord
  has_many :videos, -> { order :title }, dependent: :destroy

  scope :all_asc, -> { all.order(name: :asc) }

  validates :name, presence: true
end
