FactoryBot.define do
  factory :appointment do
    appointment_date_time_start { Faker::Time.between(from: Time.now + 1.day, to: Time.now + 20.days) }
    appointment_date_time_end { appointment_date_time_start + 1.hour }
    doctor_id { Faker::Number.number(digits: 10) }
    patient_id { Faker::Number.number(digits: 10) }
  end
end
