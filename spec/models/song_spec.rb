require 'rails_helper'

RSpec.describe Song do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should have_attached_file(:audio) }
    it do
      should validate_attachment_content_type(:audio).allowing('audio/mpeg')
    end
  end

  describe '.by_position' do
    it 'returns songs sorted by their position ascending' do
      a = create(:song, position: 3)
      b = create(:song, position: 1)
      c = create(:song, position: 2)

      expect(Song.by_position).to eq([b, c, a])
    end
  end
end
