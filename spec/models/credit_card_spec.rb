require 'rails_helper'
describe CreditCard, type: :model do

  describe '#create' do
    it 'is valid' do
      user = create(:user)
      card = build(:credit_card, user_id: user.id)
      card.valid?
      expect(card).to be_valid
    end

    it 'is invalid without customer_id' do
      user = create(:user)
      card = build(:credit_card, user_id: user.id, customer_id: nil)
      card.valid?
      expect(card.errors.full_messages).to include("Customerを入力してください")
    end

    it 'is invalid without card_id' do
      user = create(:user)
      card = build(:credit_card, user_id: user.id, card_id: "")
      card.valid?
      expect(card.errors.full_messages).to include("Cardを入力してください")
    end
  end
end