FactoryBot.define do
  factory :product do
  name                  {"テスト商品名"}
  text                  {"商品説明のテスト文章です"}
  condition             {"1"}
  price                 {"1000"}
  
  created_at { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
  updated_at { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
  
    after(:build) do |product|
      parent_category = create(:category)
      child_category = parent_category.children.create(name: "トップス")
      grand_child_category = child_category.children.create(name: "Tシャツ/カットソー(半袖/袖なし)")
      product.category_id = grand_child_category.id
      
      shipping = create(:shipping)
      product.shipping_id = shipping.id
      
      brand = create(:brand)
      product.brand_id = brand.id
      
      user = create(:user)
      product.user_id = user.id
      
      product.product_images << FactoryBot.build(:product_image, product:product)
      end
 end
  
  factory :product_image do
  image_url { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/fixtures/link.png"), 'image/png') }
  end
  
end