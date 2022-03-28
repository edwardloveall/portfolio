class ExternalPost < ApplicationRecord
  alias_attribute :guid, :url

  has_one :post, as: :postable

  validates :posted_on, presence: true
  validates :teaser, presence: true
  validates :title, presence: true
  validates :url, presence: true

  scope :newest_first, -> { order(posted_on: :desc) }
end
