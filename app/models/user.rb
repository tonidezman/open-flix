class User < ApplicationRecord
  has_secure_password

  has_many :reviews
  has_many :queue_items, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :full_name, presence: true
  validates :password, presence: true

  def next_queue_item_order_num
    starting_number = 1
    if queue_items.empty?
      starting_number
    else
      queue_items.count + 1
    end
  end
end
