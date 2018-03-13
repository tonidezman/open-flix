class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.belongs_to :video, index: true
      t.belongs_to :user, index: true
      t.integer :rating
      t.text :body, limit: 500
      t.timestamps
    end
  end
end
