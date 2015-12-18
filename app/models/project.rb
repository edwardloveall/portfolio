class Project < ActiveRecord::Base
  validates :description, presence: true
  validates :role, presence: true
  validates :title, presence: true, uniqueness: true
  validates :website, presence: true

  scope :featured, lambda { where.not(featured_at: nil) }
  scope :regular, lambda { where(featured_at: nil) }
end
