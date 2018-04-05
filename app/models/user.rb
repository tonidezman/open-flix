class User < ApplicationRecord
  has_secure_password

  has_many :reviews
  has_many :queue_items, -> { order :position }, dependent: :destroy

  has_many :friendships
  has_many :friends, through: :friendships

  validates :email, presence: true, uniqueness: true
  validates :full_name, presence: true
  validates :password, presence: true

  def next_queue_item_order_num
    starting_number = 1
    if queue_items.empty?
      starting_number
    else
      next_num = queue_items.order(position: :desc)&.last&.position
      default_value = 99
      if next_num
        next_num + 1
      else
        default_value
      end
    end
  end

  def paid?
    paid
  end

  def trial_period?
    !paid?
  end

  def followers
    Friendship.where(friend_id: id)
  end

  def can_follow?(other_user)
    return false if id == other_user.id
    Friendship.where(user_id: id, friend_id: other_user.id).empty?
  end

end
