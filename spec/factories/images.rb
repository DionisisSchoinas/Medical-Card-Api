FactoryBot.define do
  factory :image do
    image_base64 { Faker::String.random(length: [300, 400]) }
    doctor_id { Faker::Number.number(digits: 10) }
  end
end
