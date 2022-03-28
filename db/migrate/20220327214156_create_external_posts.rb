class CreateExternalPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :external_posts do |t|
      t.timestamps null: false
      t.date :posted_on, null: false
      t.string :title, null: false
      t.text :teaser, null: false
      t.text :url, null: false
    end
  end
end
