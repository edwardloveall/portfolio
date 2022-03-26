class AddTeaserToInternalPosts < ActiveRecord::Migration[7.0]
  def change
    add_column(:internal_posts, :teaser, :text, default: "", null: false)
  end
end
