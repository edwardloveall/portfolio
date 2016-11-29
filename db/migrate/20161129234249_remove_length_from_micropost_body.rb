class RemoveLengthFromMicropostBody < ActiveRecord::Migration[5.0]
  def up
    change_column :microposts, :body, :text, limit: nil
  end

  def down
    change_column :microposts, :body, :text, limit: 280
  end
end
