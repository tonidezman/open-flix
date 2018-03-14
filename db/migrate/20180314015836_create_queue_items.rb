class CreateQueueItems < ActiveRecord::Migration[5.1]
  def change
    create_table :queue_items do |t|
      t.integer :position
      t.integer :user_id, index: true
      t.integer :video_id

      t.timestamps
    end
  end
end
