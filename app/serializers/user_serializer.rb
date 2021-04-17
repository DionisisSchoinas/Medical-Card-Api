class UserSerializer < ActiveModel::Serializer
  attributes :fullname

  has_one :doctor
  has_one :patient
end
