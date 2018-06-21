require 'rails_helper'

RSpec.describe Song do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should have_attached_file(:mp3) }
    it { should have_attached_file(:ogg) }

    it "validates ogg content-type" do
      ogg_path = Rails.root.join('spec', 'fixtures', 'song.ogg')
      not_ogg_file_path = Rails.root.join('spec', 'fixtures', 'song.mp3')
      ogg = fixture_file_upload(ogg_path, 'audio/ogg')
      not_ogg = fixture_file_upload(not_ogg_file_path, 'audio/mpeg')
      song_with_ogg = build(:song, ogg: ogg)
      song_with_fake_ogg = build(:song, ogg: not_ogg)

      expect(song_with_ogg).to be_valid
      expect(song_with_fake_ogg).not_to be_valid
    end

    it "validates mp3 content-type" do
      mp3_path = Rails.root.join('spec', 'fixtures', 'song.mp3')
      not_mp3_file_path = Rails.root.join('spec', 'fixtures', 'song.ogg')
      mp3 = fixture_file_upload(mp3_path, 'audio/mpeg')
      not_mp3 = fixture_file_upload(not_mp3_file_path, 'audio/ogg')
      song_with_mp3 = build(:song, mp3: mp3)
      song_with_fake_mp3 = build(:song, mp3: not_mp3)

      expect(song_with_mp3).to be_valid
      expect(song_with_fake_mp3).not_to be_valid
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
