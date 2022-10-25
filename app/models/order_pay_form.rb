class OrderPayForm
  include ActiveModel::Model
  attr_accessor :token, :user_id, :item_id, :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number

  with_options presence: true do
    validates :token, :user_id, :item_id, :city, :addresses
    validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'ハイフン(-)を入力してください' }
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }
  end

  def save
    # 情報を保存し、変数orderに代入する
    order = Order.create(user_id: user_id, item_id: item_id)
    # 保存する
    PayForm.create(order_id: order.id, postal_code: postal_code, prefecture_id: prefecture_id, city: city, addresses: addresses,
                   building: building, phone_number: phone_number)
  end
end
