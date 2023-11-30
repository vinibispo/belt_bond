class AddUsernameToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :username, :citext, null: false, limit: 30

    add_index :users, :username, unique: true
  end
end
