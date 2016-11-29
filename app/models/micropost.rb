class Micropost < ApplicationRecord
  after_create :set_ms_epoch

  validates :body, presence: true, length: { maximum: 280 }

  scope :newest_first, lambda { order(created_at: :desc) }

  def guid
    "com.edwardloveall.microblog.#{ms_epoch}"
  end

  def timestamp
    seconds_with_milliseconds = '%s%3N'
    created_at.strftime(seconds_with_milliseconds)
  end

  def set_ms_epoch
    if ms_epoch.nil?
      update(ms_epoch: timestamp)
    end
  end
end
