class AddTumblrGuidToPosts < ActiveRecord::Migration[4.2]
  def change
    add_column :posts, :tumblr_guid, :string
  end
end
