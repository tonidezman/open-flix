class CreateVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :videos do |t|
      t.string :cover_image_url

      t.timestamps
    end
  end
end
