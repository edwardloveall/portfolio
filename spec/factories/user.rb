FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "admin#{n}@example.com" }
    password_digest "password"
    me "https://edwardloveall.com"
  end
end
