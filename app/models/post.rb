class Post < ActiveRecord::Base
  validates :body, presence: true
  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true

  scope :newest_first, lambda { order(created_at: :desc) }
end
