class User < ApplicationRecord
  has_secure_password

  has_many :reviews
  has_many :queue_items, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :full_name, presence: true
  validates :password, presence: true
end
