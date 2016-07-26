class Project < ActiveRecord::Base
  LOGO_SIZE = 174

  has_attached_file :logo, styles: { standard: '174x174' }

  validates :description, presence: true
  validates_attachment :logo,
                       presence: true,
                       content_type: { content_type: /png\Z/ }
  validates :role, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :title, presence: true, uniqueness: true
  validates :website, presence: true

  scope :featured, lambda { where.not(featured_at: nil).published.by_position }
  scope :regular, lambda { where(featured_at: nil).published.by_position }
  scope :in_display_order, lambda { order(created_at: :desc) }
  scope :by_position, lambda { order(position: :asc) }
  scope :published, lambda { where.not(published_at: nil) }

  time_for_a_boolean :published

  def to_param
    slug
  end

  def to_s
    title
  end
end
