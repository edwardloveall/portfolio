FactoryBot.define do
  factory :post do
    association :postable, factory: :internal_post
  end
end
