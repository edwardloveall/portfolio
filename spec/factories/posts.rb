FactoryBot.define do
  factory :post do
    internal

    trait :external do
      association :postable, factory: :external_post
    end

    trait :internal do
      association :postable, factory: :internal_post
    end
  end
end
