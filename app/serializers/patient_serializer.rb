class PatientSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :user
end
