class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :brand
  has_one :shipping
  has_one :order
  has_many :product_images
end
