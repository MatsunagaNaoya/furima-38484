class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @order_pay_form = OrderPayForm.new
  end

  def create
    Order.create(order_params)
  end

  private
  def order_params
    params.require(:order_pay_form).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(user_id: current_user.id, item_id: current_user.item.id)
  end

end
