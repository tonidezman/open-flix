class ChangesVideoCategoryToManyToOnRel < ActiveRecord::Migration[5.1]
  def up
    drop_table :categories_videos
    add_column :videos, :category_id, :integer
    add_index :videos, :category_id
  end

  def down
    create_table :categories_videos, id: false do |t|
      t.belongs_to :video, index: true
      t.belongs_to :category, index: true
    end
    remove_column :videos, :category_id
  end
end
