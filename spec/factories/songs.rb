FactoryGirl.define do
  factory :song do
    title 'My Song'
    audio do
      file_path = Rails.root.join('spec', 'fixtures', 'song.mp3')
      fixture_file_upload(file_path, 'audio/mpeg')
    end
    description <<-DESC.strip_heredoc
      My song is originally by makingthenoise.
      Remixed in 2011 by Edward Loveall a.k.a. Arbiter.
    DESC
  end
end