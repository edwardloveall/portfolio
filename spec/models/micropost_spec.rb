require 'rails_helper'

RSpec.describe Micropost do
  describe 'callbacks' do
    it 'should set the ms_epoch after the object is created' do
      micropost = Micropost.create(body: 'Magic')

      expect(micropost.ms_epoch).not_to be_nil
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:body) }
    it { should validate_length_of(:body).is_at_most(280) }
  end

  describe '#guid' do
    it 'returns the guid for the micropost' do
      micropost = create(:micropost)
      guid = "com.edwardloveall.microblog.#{micropost.ms_epoch}"

      expect(micropost.guid). to eq(guid)
    end
  end

  describe '#timestamp' do
    it 'returns the milliseconds since the epoch' do
      date = Time.zone.parse('January 1st, 2016')
      micropost = create(:micropost, created_at: date)

      result = micropost.timestamp

      expect(result).to eq('1451606400000')
    end
  end
end
