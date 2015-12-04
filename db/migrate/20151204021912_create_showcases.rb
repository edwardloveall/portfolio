class CreateShowcases < ActiveRecord::Migration
  def change
    create_table :showcases do |t|
      t.timestamps
      t.string :title
    end

    add_index :showcases, :title, unique: true
  end
end
