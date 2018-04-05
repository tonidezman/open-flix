class AddUniqueConstraintForReview < ActiveRecord::Migration[5.1]
  def change
    add_index :reviews, [:user_id, :video_id], unique: true
  end
end
