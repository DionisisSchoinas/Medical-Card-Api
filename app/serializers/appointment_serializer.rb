class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :appointment_date, :duration_minutes

  belongs_to :doctor
  belongs_to :patient
end
