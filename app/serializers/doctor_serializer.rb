class DoctorSerializer < ActiveModel::Serializer
  attributes :id, :speciality, :office_address, :phone, :email, :cost
  belongs_to :user
  has_one :image
end
