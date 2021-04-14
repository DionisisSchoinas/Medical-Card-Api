FactoryBot.define do
  factory :patient do
    user_id { Faker::Number.number(digits: 10) }
  end
end
