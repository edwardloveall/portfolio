class RenamePostsToInternalPosts < ActiveRecord::Migration[7.0]
  def change
    rename_table("posts", "internal_posts")
  end
end
