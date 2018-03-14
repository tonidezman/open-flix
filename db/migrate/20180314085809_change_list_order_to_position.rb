class ChangeListOrderToPosition < ActiveRecord::Migration[5.1]
  def change
    rename_column :queue_items, :position, :position
  end
end
