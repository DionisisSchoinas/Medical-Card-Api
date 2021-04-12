class UserSerializer < ActiveModel::Serializer
  attributes :fullname, :date_of_birth
  has_one :doctor
  has_one :patient
end
