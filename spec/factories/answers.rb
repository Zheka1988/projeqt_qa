FactoryBot.define do
  sequence :body do |n|
    "MyTextAnswer#{n}"
  end

  factory :answer do
    body
    question { nil }
    best { false }
    association :author, factory: :user

    trait :invalid do
      body { nil }
    end
  end
end
