class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.integer :user_id, index: true
      t.integer :amount
      t.string :reference_id

      t.timestamps
    end
  end
end
