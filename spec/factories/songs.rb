include ActionDispatch::TestProcess

FactoryBot.define do
  factory :song do
    title { 'My Song' }
    mp3 do
      file_path = Rails.root.join('spec', 'fixtures', 'song.mp3')
      Rack::Test::UploadedFile.new(file_path, 'audio/mpeg')
    end
    ogg do
      file_path = Rails.root.join('spec', 'fixtures', 'song.ogg')
      Rack::Test::UploadedFile.new(file_path, 'audio/ogg')
    end
    description do
      <<-DESC.strip_heredoc
        My song is originally by makingthenoise.
        Remixed in 2011 by Edward Loveall a.k.a. Arbiter.
      DESC
    end
  end
end
