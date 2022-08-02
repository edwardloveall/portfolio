class CreateProjects < ActiveRecord::Migration[4.2]
  def change
    create_table :projects do |t|
      t.timestamps null: false
      t.string :title
      t.attachment :logo
      t.string :role
      t.string :website
      t.text :description
      t.datetime :featured_at
    end

    add_index :projects, :title, unique: true
  end
end
