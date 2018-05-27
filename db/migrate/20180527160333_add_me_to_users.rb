class AddMeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :me, :text
  end
end
