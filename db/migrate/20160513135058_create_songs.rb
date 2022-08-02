class CreateSongs < ActiveRecord::Migration[4.2]
  def change
    create_table :songs do |t|
      t.timestamps null: false
      t.string :title
      t.text :description
      t.attachment :audio
    end
  end
end
