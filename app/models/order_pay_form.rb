class OrderPayForm
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :order_id, :postal_code, :prefecture_id,:city, :addresses, :building, :phone_number

  with_options presence: true do
    validates :user_id, :item_id, :order_id, 
              :prefecture_id,:city, :addresses 
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :phone_number, format: {with: / \A \d {10,11} \z /}
  end

  def save
    # 寄付情報を保存し、変数orderに代入する
    order = Order.create(user_id: user_id, item_id: item_id)
    # を保存する
    PayForm.create(order_id: order.id, postal_code: postal_code, prefecture_id: prefecture_id, city: city, addresses: addresses, building: building, phone_number: phone_number)
  end
end