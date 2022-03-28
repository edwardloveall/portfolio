FactoryBot.define do
  factory :external_post do
    posted_on { Date.today.to_s }
    title { "External Title" }
    url { "https://example.com/" }
    teaser { "I posted this on a different site" }
  end
end
