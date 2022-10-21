require 'rails_helper'

RSpec.describe OrderPayForm, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.build(:item)
    item.image = fixture_file_upload('app/assets/images/furima-intro02.png')
    item.save
    @order_pay_form = FactoryBot.build(:order_pay_form, user_id: user.id, item_id: item.id)
  end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_pay_form).to be_valid
      end
    end
  
end
