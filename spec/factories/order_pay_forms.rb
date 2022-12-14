FactoryBot.define do
  factory :order_pay_form do
    token { 'tok_abcdefghijk00000000000000000' }
    postal_code { '123-4567' }
    prefecture_id { 2 }
    city { '東京都' }
    addresses { '品川区1-1' }
    building { '東京ハイツ' }
    phone_number { '1209991119' }
  end
end
