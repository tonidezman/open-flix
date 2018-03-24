class AddPaymentInfoToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :paid, :boolean
    add_column :users, :reference_id, :string
    add_column :users, :amount, :integer

    add_index :users, :paid
  end

end
