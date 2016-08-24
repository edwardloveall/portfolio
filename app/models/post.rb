class Post < ActiveRecord::Base
  validates :body, presence: true
  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true

  scope :newest_first, lambda { order(created_at: :desc) }

  def guid
    if tumblr_guid.nil?
      "com.edwardloveall.blog.#{slug}"
    else
      "http://blog.edwardloveall.com/post/#{tumblr_guid}"
    end
  end
end
