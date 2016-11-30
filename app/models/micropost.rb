class Micropost < ApplicationRecord
  MAX_POST_SIZE = 280
  after_create :set_ms_epoch

  validates :body, presence: true
  validate :rendered_body_is_less_than_280_characters

  scope :newest_first, lambda { order(created_at: :desc) }

  def rendered_body_is_less_than_280_characters
    text = MarkdownRenderer.to_text(body)
    if text.length > MAX_POST_SIZE
      errors.add(:body, "text maximum is #{MAX_POST_SIZE} characters")
    end
  end

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
