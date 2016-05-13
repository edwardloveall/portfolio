FactoryGirl.define do
  factory :song do
    title 'My Song'
    logo do
      file_path = Rails.root.join('spec', 'fixtures', 'pull_feed_2x.png')
      fixture_file_upload(file_path, 'audio/mpeg')
    end
    description <<-DESC.strip_heredoc
      My is originally by makingthenoise.
      Remixed in 2011 by Edward Loveall a.k.a. Arbiter.
    DESC
  end
end
