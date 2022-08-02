class CreatePosts < ActiveRecord::Migration[4.2]
  def change
    create_table :posts do |t|
      t.timestamps null: false
      t.string :title
      t.text :body
    end
  end
end
