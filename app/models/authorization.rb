class Authorization < ApplicationRecord
  before_create :generate_code

  validates_presence_of :client_id

  def generate_code
    self.code = SecureRandom.hex(6)
    self.code_expires_at = 1.day.from_now
  end
end
