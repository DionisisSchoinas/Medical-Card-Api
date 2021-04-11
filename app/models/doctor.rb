class Doctor < ApplicationRecord
  # Model Associations
  belongs_to :user

  has_one :image, dependent: :destroy
  has_many :appointments, dependent: :destroy
  has_many :patients, through: :appointments

  # Validations
  validates_presence_of :speciality, :office_address, :phone, :email, :cost
end
