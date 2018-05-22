FactoryGirl.define do
  factory :authorization do
    client_id "https://service.com"
    scope "create update delete undelete"
  end
end
