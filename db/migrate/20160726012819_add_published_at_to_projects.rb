class AddPublishedAtToProjects < ActiveRecord::Migration[4.2]
  def change
    add_column :projects, :published_at, :datetime
  end
end
