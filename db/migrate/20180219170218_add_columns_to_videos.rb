class AddColumnsToVideos < ActiveRecord::Migration[5.1]
  def up
    add_column :videos, :title, :string
    add_column :videos, :description, :text
    add_column :videos, :small_cover_url, :string
    add_column :videos, :large_cover_url, :string
    remove_column :videos, :cover_image_url
  end

  def down
    remove_column :videos, :title
    remove_column :videos, :description
    remove_column :videos, :small_cover_url
    remove_column :videos, :large_cover_url
    add_column :videos, :cover_image_url, :string
  end
end
