FactoryBot.define do
  factory :product do
    name                  {"テスト商品名"}
    text                  {"商品説明のテスト文章です"}
    condition             {"1"}
    price                 {"1000"}
    category           
    shipping           
    brand              
    user               
    created_at { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
    updated_at { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }

    after(:build) do |built_product|
      built_product.product_images << FactoryBot.build(:product_image, product:built_product)
    end
  end

  factory :product_image do
    image_url { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/fixtures/link.png"), 'image/png') }
  end

end