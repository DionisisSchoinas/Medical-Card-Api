class PatientSerializer < ActiveModel::Serializer
  attributes :id

  belongs_to :user
  has_many :appointments
end
