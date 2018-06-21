class Project < ApplicationRecord
  LOGO_SIZE = 174

  has_one_attached :logo

  validate :correct_logo_content_type
  validates :description, presence: true
  validates :role, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :title, presence: true, uniqueness: true
  validates :website, presence: true

  scope :featured, lambda { where.not(featured_at: nil).published.by_position }
  scope :regular, lambda { where(featured_at: nil).published.by_position }
  scope :in_display_order, lambda { order(created_at: :desc) }
  scope :by_position, lambda { order(position: :asc) }
  scope :published, lambda { where.not(published_at: nil) }

  time_for_a_boolean :featured
  time_for_a_boolean :published

  def to_param
    slug
  end

  def to_s
    title
  end

  def correct_logo_content_type
    if logo.attached? && logo.content_type != "image/png"
      errors.add(:logo, "must be 'image/png'")
    end
  end
end
