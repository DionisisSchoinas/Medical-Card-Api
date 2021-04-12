class ImageSerializer < ActiveModel::Serializer
  attributes :image_base64
  belongs_to :doctor
end
