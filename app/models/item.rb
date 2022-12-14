class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one_attached :image
  belongs_to :category
  belongs_to :sales_status
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery
  has_one :order

  with_options presence: true do
    validates :image, :name, :info
    validates :price, numericality: { only_integer: true,
                                      greater_than_or_equal_to: 300,
                                      less_than_or_equal_to: 9_999_999 }
  end
  validates :category_id, :sales_status_id,
            :shipping_fee_status_id, :prefecture_id,
            :scheduled_delivery_id,
            numericality: { other_than: 1, message: 'を選択してください' }
end
