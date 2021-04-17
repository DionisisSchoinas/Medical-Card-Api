class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :appointment_date_time_start, :appointment_date_time_end

  belongs_to :doctor
  belongs_to :patient

  class DoctorSerializer < ActiveModel::Serializer
    attributes :id, :speciality, :office_address

    belongs_to :user
    has_one :image
    has_many :appointments
  end
end
