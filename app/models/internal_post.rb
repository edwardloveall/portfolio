class InternalPost < ApplicationRecord
  has_one :post, as: :postable

  validates :body, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :teaser, presence: true
  validates :title, presence: true

  scope :newest_first, lambda { order(created_at: :desc) }

  def guid
    if tumblr_guid.nil?
      "com.edwardloveall.blog.#{slug}"
    else
      "http://blog.edwardloveall.com/post/#{tumblr_guid}"
    end
  end
end
