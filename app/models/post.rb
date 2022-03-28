class Post < ApplicationRecord
  belongs_to :postable, polymorphic: true

  delegate :created_at, :guid, :updated_at, to: :postable

  scope :with_internal_posts, -> do
    joins(<<~SQL)
      LEFT JOIN internal_posts
      ON internal_posts.id = posts.postable_id
      AND posts.postable_type = 'InternalPost'
    SQL
  end

  scope :with_external_posts, -> do
    joins(<<~SQL)
      LEFT JOIN external_posts
      ON external_posts.id = posts.postable_id
      AND posts.postable_type = 'ExternalPost'
    SQL
  end

  scope :newest_first, -> do
    select(<<~SQL).
      posts.*,
      COALESCE(
        internal_posts.created_at,
        external_posts.posted_on
      ) AS created_at
    SQL
    includes(:postable).
    with_internal_posts.
    with_external_posts.
    order(created_at: :desc)
  end
end
