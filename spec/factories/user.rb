FactoryGirl.define do
  factory :user do
    email "admin@example.com"
    password_digest "password"
    me "https://edwardloveall.com"
  end
end
