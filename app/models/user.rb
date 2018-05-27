class User < ApplicationRecord
  has_many :authorizations

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
end
