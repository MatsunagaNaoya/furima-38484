class OrdersController < ApplicationController
  before_action :move_to_index
  before_action :authenticate_user!

  def index
    @item = Item.find(params[:item_id])
    @order_pay_form = OrderPayForm.new
  end

  def create
    @item = Item.find(params[:item_id])
    @order_pay_form = OrderPayForm.new(order_params)
    if @order_pay_form.valid?
      pay_item
      @order_pay_form.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def order_params
    params.require(:order_pay_form).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number)
    .merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    @item = Item.find(params[:item_id])
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item[:price],  # 商品の値段
      card: order_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

  def move_to_index
    @item = Item.find(params[:item_id])
    if (current_user == @item.user) || @item.order
      redirect_to root_path
    end
  end
end
#/items/1/orders