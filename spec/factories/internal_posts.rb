FactoryBot.define do
  factory :internal_post do
    title { "A Scary Story" }
    body { "It was a dark and stormy night..." }
    sequence(:slug) { |n| "a-scary-story-#{n}" }
  end
end
