FactoryBot.define do
  factory :doctor do
    speciality { Faker::Job.field }
    office_address { Faker::Address.full_address }
    phone { Faker::PhoneNumber.phone_number }
    email { Faker::Internet.email }
    cost { Faker::Number.between(from: 50.0, to: 100.0) }
    user_id { Faker::Number.number(digits: 10) }
  end
end
