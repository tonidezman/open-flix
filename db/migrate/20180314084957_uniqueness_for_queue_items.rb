class UniquenessForQueueItems < ActiveRecord::Migration[5.1]
  def change
    add_index :queue_items, [:user_id, :video_id], unique: true
  end
end
