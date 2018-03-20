class CreateResetPasswords < ActiveRecord::Migration[5.1]
  def change
    create_table :reset_passwords do |t|
      t.string :token
      t.string :email

      t.timestamps
    end

    add_index :reset_passwords, :email, unique: true
    add_index :reset_passwords, :token
    add_index :reset_passwords, [:token, :email]
  end
end
