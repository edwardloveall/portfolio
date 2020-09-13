class RemoveMicroposts < ActiveRecord::Migration[6.0]
  def up
    drop_table :microposts
  end

  def down
    create_table :microposts do |t|
      t.timestamps null: false
      t.text :body
      t.string :ms_epoch
    end
  end
end
