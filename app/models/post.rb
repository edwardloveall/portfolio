class Post < ActiveRecord::Base
  validates :body, presence: true
  validates :title, presence: true

  scope :newest_first, lambda { order(created_at: :desc) }
end
