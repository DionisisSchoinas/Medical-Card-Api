class UserSerializer < ActiveModel::Serializer
  attributes :id, :fullname, :date_of_birth
  has_one :doctor
  has_one :patient
end
