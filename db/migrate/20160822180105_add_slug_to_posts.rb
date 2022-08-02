class AddSlugToPosts < ActiveRecord::Migration[4.2]
  def change
    add_column :posts, :slug, :string, unique: true, index: true
  end
end
