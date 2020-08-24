class ProductImage < ApplicationRecord
  mount_uploader :image_url, ImageUploader
  belongs_to :product
end
