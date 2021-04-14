FactoryBot.define do
  factory :user do
    amka { Faker::Number.number(digits: 10) }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    fullname { Faker::Name.name }
    date_of_birth { Faker::Date.between(from: '1950-01-01', to: Date.today) }
  end
end
