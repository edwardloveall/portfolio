class Micropost < ApplicationRecord
  validates :body, presence: true, length: { maximum: 280 }

  def guid
    "com.edwardloveall.microblog.#{timestamp}"
  end

  def timestamp
    microseconds = created_at.to_f * 1_000_000
    microseconds.to_i
  end
end
