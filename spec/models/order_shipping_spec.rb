require 'rails_helper'

RSpec.describe OrderShipping, type: :model do
  describe '配送先の保存' do
    before do
      item = FactoryBot.create(:item)
      user = FactoryBot.create(:user)
      @order_shipping = FactoryBot.build(:order_shipping, user_id: user.id, item_id: item.id)
    end

    context '内容に問題ない場合' do
      it 'すべての値とtokenがあれば保存できること' do
        expect(@order_shipping).to be_valid
      end
      it 'buildingは空でも保存できること' do
        @order_shipping.building = ''
        expect(@order_shipping).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postal_codeが空だと保存できないこと' do
        @order_shipping.postal_code = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_shipping.postal_code = '1234567'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it 'prefecture_idを選択していないと保存できないこと' do
        @order_shipping.prefecture_id = 0
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空だと保存できないこと' do
        @order_shipping.city = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("City can't be blank")
      end
      it 'addressesが空だと保存できないこと' do
        @order_shipping.addresses = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Addresses can't be blank")
      end
      it 'phone_numberが空だと保存できないこと' do
        @order_shipping.phone_number = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが半角数値でないと保存できないこと' do
        @order_shipping.phone_number = '１２３４５６７８９０'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Phone number is invalid. Include hyphen(-)")
      end
      it 'phone_numberが10桁以上11桁以内でないと保存できないこと' do
        @order_shipping.phone_number = '12345'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Phone number is invalid. Include hyphen(-)")
      end
      it 'userが紐付いていないと保存できないこと' do
        @order_shipping.user_id = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("User can't be blank")
      end

      it "tokenが空では登録できないこと" do
        @order_shipping.token = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
