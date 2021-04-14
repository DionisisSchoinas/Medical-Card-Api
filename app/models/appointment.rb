class Appointment < ApplicationRecord
  # Model Associations
  belongs_to :doctor
  belongs_to :patient

  # Validations
  validates_presence_of :appointment_date_time_start, :appointment_date_time_end, :doctor_id, :patient_id

  validates :appointment_date_time_start, uniqueness: { scope: :doctor_id, message: "already booked for this doctor" }
  validate :start_date_cannot_be_earlier_than_6_hours

  validate :end_date_cannot_be_earlier_than_start_date

  def start_date_cannot_be_earlier_than_6_hours
    errors.add(:appointment_date_time_start, "must be at least 6 hours after the current time in UTC") if appointment_date_time_start.to_datetime < (Time.now.utc + 6.hours) unless appointment_date_time_start.nil?
  end

  def end_date_cannot_be_earlier_than_start_date
    errors.add(:appointment_date_time_end, "must be later than Appointment date time start") if appointment_date_time_start.to_datetime >= appointment_date_time_end.to_datetime unless appointment_date_time_start.nil? || appointment_date_time_end.nil?
  end
end
