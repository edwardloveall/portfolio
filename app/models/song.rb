class Song < ApplicationRecord
  has_one_attached :mp3
  has_one_attached :ogg

  validates :title, presence: true
  validates :mp3, presence: true
  validates :ogg, presence: true
  validate :correct_mp3_content_type
  validate :correct_ogg_content_type

  scope :by_position, lambda { order(position: :asc) }

  def to_s
    title
  end

  def correct_mp3_content_type
    if mp3.attached? && mp3.content_type != "audio/mpeg"
      errors.add(:mp3, "must be 'audio/mpeg'")
    end
  end

  def correct_ogg_content_type
    if ogg.attached? && ogg.content_type != "audio/ogg"
      errors.add(:ogg, "must be 'audio/ogg'")
    end
  end
end
