class Image < ApplicationRecord
  # Model Associations
  belongs_to :doctor

  # Validations
  validates_presence_of :image_base64

  validates :doctor_id, uniqueness: true
end
