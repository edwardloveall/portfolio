class Project < ActiveRecord::Base
  belongs_to :showcase

  validates :description, presence: true
  validates :role, presence: true
  validates :title, presence: true, uniqueness: true
  validates :website, presence: true
end
