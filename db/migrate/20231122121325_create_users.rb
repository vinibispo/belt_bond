class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.binary :encrypted_email, null: false
      t.text :email_digest, null: false
      t.bigint :keyring_id, null: false

      t.timestamps
    end
    add_index :users, :email_digest, unique: true
  end
end
