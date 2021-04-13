class User < ApplicationRecord
  # encrypt password
  has_secure_password

  # Model Associations
  has_one :doctor, dependent: :destroy
  has_one :patient, dependent: :destroy

  # Validations
  validates_presence_of :amka, :email, :password_digest, :fullname, :date_of_birth, :password_confirmation
  validates :amka, uniqueness: true
  validates :email, uniqueness: true
end
