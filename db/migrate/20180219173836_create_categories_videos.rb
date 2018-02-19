class CreateCategoriesVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :categories_videos, id: false do |t|
      t.belongs_to :video, index: true
      t.belongs_to :category, index: true
    end
  end
end
