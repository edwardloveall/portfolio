class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.timestamps null: false
      t.string :email, null: false
      t.string :password_digest, null: false
    end

    add_index :users, :email, unique: true
  end
end
