class AddSlugToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :slug, :string, unique: true, index: true
  end
end
