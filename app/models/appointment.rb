class Appointment < ApplicationRecord
  # Model Associations
  belongs_to :doctor
  belongs_to :patient

  # Validations
  validates_presence_of :appointment_date, :duration_minutes, :doctor_id, :patient_id
  validates :appointment_date, uniqueness: true
end
