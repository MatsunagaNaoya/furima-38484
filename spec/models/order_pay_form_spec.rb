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
      expect(@order_pay_form.errors.full_messages).to include('郵便番号を入力してください')
    end
    it 'postal_codeにハイフン(-)無しでは購入できない' do
      @order_pay_form.postal_code = '1234567'
      @order_pay_form.valid?
      expect(@order_pay_form.errors.full_messages).to include('郵便番号ハイフン(-)を入力してください')
    end
    it 'Prefecture_idが1番(---)では登録できない' do
      @order_pay_form.prefecture_id = 1
      @order_pay_form.valid?
      expect(@order_pay_form.errors.full_messages).to include('都道府県を選択してください')
    end
    it 'cityが空では登録できない' do
      @order_pay_form.city = ''
      @order_pay_form.valid?
      expect(@order_pay_form.errors.full_messages).to include('市区町村を入力してください')
    end
    it 'addressesが空では登録できない' do
      @order_pay_form.addresses = ''
      @order_pay_form.valid?
      expect(@order_pay_form.errors.full_messages).to include('番地を入力してください')
    end
    it 'phone_numberが空では登録できない' do
      @order_pay_form.phone_number = ''
      @order_pay_form.valid?
      expect(@order_pay_form.errors.full_messages).to include('電話番号を入力してください')
    end
    it 'phone_numberが9桁以下では登録できない' do
      @order_pay_form.phone_number = '123456789'
      @order_pay_form.valid?
      expect(@order_pay_form.errors.full_messages).to include('電話番号は不正な値です')
    end
    it 'phone_numberが12桁以上では登録できない' do
      @order_pay_form.phone_number = '000044448888'
      @order_pay_form.valid?
      expect(@order_pay_form.errors.full_messages).to include('電話番号は不正な値です')
    end
    it 'phone_numberが英数混合では登録できない' do
      @order_pay_form.phone_number = '012o-21090'
      @order_pay_form.valid?
      expect(@order_pay_form.errors.full_messages).to include('電話番号は不正な値です')
    end
    it 'tokenが空では登録できないこと' do
      @order_pay_form.token = nil
      @order_pay_form.valid?
      expect(@order_pay_form.errors.full_messages).to include('クレジットカード情報を入力してください')
    end
    it 'user_idが無いと購入できない' do
      @order_pay_form.user_id = ''
      @order_pay_form.valid?
      expect(@order_pay_form.errors.full_messages).to include('Userを入力してください')
    end
    it 'item_idが無いと購入できない' do
      @order_pay_form.item_id = ''
      @order_pay_form.valid?
      expect(@order_pay_form.errors.full_messages).to include('Itemを入力してください')
    end
  end
end
