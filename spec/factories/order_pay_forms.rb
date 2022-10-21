FactoryBot.define do
  factory :order_pay_form do
    postal_code { '123-4567' }
    prefecture_id { 1 }
    city { '東京都' }
    addresses { '品川区1-1' }
    building { '東京ハイツ' }
    phone_number { '1209991119' }
    association :user
    association :item
  end
end
