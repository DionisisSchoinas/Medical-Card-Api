class AppointmentForDoctorSerializer < ActiveModel::Serializer
  attributes :id, :appointment_date_time_start, :appointment_date_time_end

  belongs_to :doctor
  belongs_to :patient

  class PatientSerializer < ActiveModel::Serializer
    attributes :id

    belongs_to :user
    has_many :appointments

    class UserSerializer < ActiveModel::Serializer
      attributes :fullname, :date_of_birth

      has_one :doctor
      has_one :patient
    end
  end
end
