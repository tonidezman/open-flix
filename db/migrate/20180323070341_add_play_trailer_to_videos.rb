class AddPlayTrailerToVideos < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :trailer_url, :string
  end
end
