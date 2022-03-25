class RecreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |table|
      table.references :postable, polymorphic: { default: "InternalPost" }
    end


    TmpInternalPost.in_batches.each do |batch|
      batch.each do |internal_post|
        Post.create!(
          postable_id: internal_post.id,
          postable_type: "InternalPost"
        )
      end
    end
  end

  class TmpInternalPost < ApplicationRecord
    self.table_name = "internal_posts"
  end

  class Post < ApplicationRecord
    belongs_to :postable, polymorphic: true
  end
end
