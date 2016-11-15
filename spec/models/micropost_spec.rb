require 'rails_helper'

RSpec.describe Micropost do
  describe 'validations' do
    it { should validate_presence_of(:body) }
    it { should validate_length_of(:body).is_at_most(280) }
  end

  describe '#guid' do
    it 'returns the guid for the micropost' do
      micropost = create(:micropost)
      guid = "com.edwardloveall.microblog.#{micropost.timestamp}"

      expect(micropost.guid). to eq(guid)
    end
  end

  describe '#timestamp' do
    it 'returns the microseconds since the epoch' do
      micropost = create(:micropost)
      microseconds = micropost.created_at.to_f * 1_000_000
      timestamp = microseconds.to_i

      result = micropost.timestamp

      expect(result).to eq(timestamp)
    end
  end
end
