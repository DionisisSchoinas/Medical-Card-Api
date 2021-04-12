class Appointment < ApplicationRecord
  # Model Associations
  belongs_to :doctor
  belongs_to :patient

  # Validations
  validates_presence_of :appointment_date_time_start, :appointment_date_time_end, :doctor_id, :patient_id

  validates :appointment_date_time_start,
    uniqueness: { scope: :doctor_id, message: "already booked for this doctor" },
    numericality: { only_integer: true, message: "must be represented in seconds since Epoch" }
  validates :appointment_date_time_start, numericality: { greater_than: 12.hours.from_now.to_i, message: "must be at least 12 hours after the current time" }

  validates :appointment_date_time_end, numericality: { only_integer: true, message: "must be represented in seconds since Epoch" }
  validates :appointment_date_time_end, numericality: { greater_than: :appointment_date_time_start, message: "must be greater than Appointment date time start"}
end
