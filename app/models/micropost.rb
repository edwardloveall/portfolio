class Micropost < ApplicationRecord
  validates :body, presence: true, length: { maximum: 280 }

  def guid
    "com.edwardloveall.microblog.#{created_at.to_i}"
  end
end
