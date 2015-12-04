FactoryGirl.define do
  factory :project do
    sequence(:title) { |n| "Project #{n}" }
    role { [:design, :development, :everything].sample }
    website 'http://example.com'
    description <<-DESC.strip_heredoc
    Pull Feed is a tool to keep you up to date with a GitHub repository via a news feed of incoming pull requests.

    It is entirely free and open source.
    DESC

    trait :featured do
      featured { Time.current }
    end
  end
end
