class Category < ApplicationRecord
  has_many :videos, dependent: :destroy
end
