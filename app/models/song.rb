class Song < ActiveRecord::Base
  has_attached_file :mp3
  has_attached_file :ogg

  validates :title, presence: true
  validates_attachment :mp3,
                       presence: true,
                       content_type: { content_type: 'audio/mpeg' }
  validates_attachment :ogg, presence: true
  scope :by_position, lambda { order(position: :asc) }

  def to_s
    title
  end
end
