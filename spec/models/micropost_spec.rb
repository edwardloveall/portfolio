require 'rails_helper'

RSpec.describe Micropost do
  describe 'validations' do
    it { should validate_presence_of(:body) }
    it { should validate_length_of(:body).is_at_most(280) }
  end

  describe '#guid' do
    it 'returns the guid for the micropost' do
      micropost = create(:micropost)
      guid = "com.edwardloveall.microblog.#{micropost.created_at.to_i}"

      expect(micropost.guid). to eq(guid)
    end
  end
end
