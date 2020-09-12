require 'rails_helper'
describe Product, type: :model do


  describe '#create' do
    context 'productを保存できる場合' do
      it '必須項目があれば保存できること' do 
        expect(build(:product, brand_id: nil)).to be_valid
      end
    end

    context 'productを保存できない場合' do
      it 'nameが空だと保存できないこと' do
        product = build(:product, name: nil)
        product.valid?
        expect(product.errors[:name]).to include("を入力してください")
      end 

      it 'textが空だと保存できないこと' do
        product = build(:product, text: nil)
        product.valid?
        expect(product.errors[:text]).to include("を入力してください")
      end
      
      it 'priceが空だと保存できないこと' do
        product = build(:product, price: nil)
        product.valid?
        expect(product.errors[:price]).to include("を入力してください")
      end

      it 'category_idが空だと保存できないこと' do
        product = build(:product)
        product.category_id = nil
        product.valid?
        expect(product.errors[:category]).to include("を入力してください")
      end
    end

  end
end
