require 'rails_helper'

describe ProductsController do
  let(:category) { create(:category) }
  let(:user) { create(:user) }
  let(:shipping) { build(:shipping) }
  let(:brand) { build(:brand) }
  let(:image_url) { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/fixtures/link.png"), 'image/png') }
  context 'ログインしている場合' do
    before do
      login user
    end

    describe  'GET #new' do
      it "new.html.hamlに遷移すること" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe '#create' do
      let(:params) { { "product[product_images_attributes][0]": {image_url: image_url}, "product[brand_attributes]": {name: brand.name}, user_id: user.id, "product[shipping_attributes]": shipping.attributes, "product[category_id]": category.id, product: attributes_for(:product) } }
     
     context '保存に成功した場合' do
      subject {
        post :create,
        params: params
      }

      it 'productを保存すること' do
        expect{ subject }.to change(Product, :count).by(1)
      end
    end
  end  
 end 
end
