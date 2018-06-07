FactoryBot.define do
  factory :project do
    logo do
      file_path = Rails.root.join('spec', 'fixtures', 'pull_feed_2x.png')
      fixture_file_upload(file_path, 'image/png')
    end
    sequence(:title) { |n| "Project #{n}" }
    sequence(:slug) { |n| "project-#{n}" }
    role { ['design', 'development', 'everything'].sample }
    website 'http://example.com'
    description <<-DESC.strip_heredoc
    Pull Feed is a tool to keep you up to date with a GitHub repository via a
    news feed of incoming pull requests.

    It is entirely free and open source.
    DESC
    published_at { Time.current }

    trait :featured do
      featured_at { Time.current }
    end

    trait :published do
      published_at { Time.current }
    end
  end
end
