class SingleAppointmentSerializer < ActiveModel::Serializer
  attributes :id, :appointment_date_time_start, :appointment_date_time_end

  belongs_to :doctor
  belongs_to :patient
end
