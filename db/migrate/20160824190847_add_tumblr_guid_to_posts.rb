class AddTumblrGuidToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :tumblr_guid, :string
  end
end
