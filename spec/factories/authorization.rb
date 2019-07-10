FactoryBot.define do
  factory :authorization do
    client_id { "https://service.com" }
    scope { "create update delete undelete" }
    user
  end
end
