class Category < ApplicationRecord
  has_many :brands
  has_many :products
  has_ancestry
end
