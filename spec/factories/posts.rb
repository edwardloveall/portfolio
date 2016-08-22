FactoryGirl.define do
  factory :post do
    title 'A Scary Story'
    body 'It was a dark and stormy night...'
    slug { |n| "a-scary-story-#{n}" }
  end
end
