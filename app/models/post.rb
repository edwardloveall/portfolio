class Post < ApplicationRecord
  belongs_to :postable, polymorphic: true

  delegate :created_at, :updated_at, to: :postable

  scope :newest_first, -> do
    includes(:postable).
    joins(<<~SQL).
      JOIN internal_posts
      ON internal_posts.id = posts.postable_id
      AND posts.postable_type = 'InternalPost'
    SQL
    merge(InternalPost.newest_first)
  end

  def guid
    tumblr_guid = postable.tumblr_guid
    if tumblr_guid.nil?
      "com.edwardloveall.blog.#{postable.slug}"
    else
      "http://blog.edwardloveall.com/post/#{tumblr_guid}"
    end
  end
end
