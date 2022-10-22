require 'rails_helper'

RSpec.describe OrderPayForm, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.build(:item)
    item.image = fixture_file_upload('app/assets/images/furima-intro02.png')
    item.save
    @order_pay_form = FactoryBot.build(:order_pay_form, user_id: user.id, item_id: item.id)
  end

    context '商品を購入できる場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_pay_form).to be_valid
      end
      it 'buildingが無しでも保存できる' do
        @order_pay_form.building = ''
        expect(@order_pay_form).to be_valid
      end
    end
    context '商品を購入できない場合' do
      it 'postal_codeが空では購入できない' do
        @order_pay_form.postal_code = ''
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeにハイフン(-)無しでは購入できない' do
        @order_pay_form.postal_code = '1234567'
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it 'Prefecture_idが1番(---)では登録できない' do
        @order_pay_form.prefecture_id = 1
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空では登録できない' do
        @order_pay_form.city = ''
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include("City can't be blank")
      end
      it 'addressesが空では登録できない' do
        @order_pay_form.addresses = ''
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include("Addresses can't be blank")
      end
      it 'phone_numberが空では登録できない' do
        @order_pay_form.phone_number = ''
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが9桁以下では登録できない' do
        @order_pay_form.phone_number = '123456789'
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include("Phone number is invalid")
      end
      it 'phone_numberが12桁以上では登録できない' do
        @order_pay_form.phone_number = '000044448888'
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include("Phone number is invalid")
      end
      it "tokenが空では登録できないこと" do
        @order_pay_form.token = nil
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include("Token can't be blank")
      end
    end
end
