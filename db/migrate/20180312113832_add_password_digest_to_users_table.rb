class AddPasswordDigestToUsersTable < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :password_digest, :string, limit: 72
  end
end
