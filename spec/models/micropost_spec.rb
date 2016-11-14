require 'rails_helper'

RSpec.describe Micropost do
  describe 'validations' do
    it { should validate_presence_of(:body) }
    it { should validate_length_of(:body).is_at_most(280) }
  end
end
