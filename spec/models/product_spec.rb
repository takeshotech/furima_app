require 'rails_helper'
describe Product, type: :model do


  describe '#create' do
    context 'productを保存できる場合' do
      it '必須項目があれば保存できること' do 
        expect(build(:product, brand_id: nil)).to be_valid
      end
    end
  end
end
