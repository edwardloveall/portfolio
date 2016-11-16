class CreateMicroposts < ActiveRecord::Migration[5.0]
  def change
    create_table :microposts do |t|
      t.timestamps null: false
      t.text :body, limit: 280
      t.string :ms_epoch
    end
  end
end
