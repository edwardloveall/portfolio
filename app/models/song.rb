class Song < ActiveRecord::Base
  has_attached_file :audio

  validates :title, presence: true
  validates_attachment :audio,
                       presence: true,
                       content_type: { content_type: 'audio/mpeg' }
  scope :by_position, lambda { order(position: :asc) }
end
