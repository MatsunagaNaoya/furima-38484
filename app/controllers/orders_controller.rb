class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @order_pay_form = OrderPayForm.new
  end

  def create
    @item = Item.find(params[:item_id])
    @order_pay_form = OrderPayForm.new(order_params)
    if @order_pay_form.valid?
      @order_pay_form.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def order_params
    params.require(:order_pay_form).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number)
    .merge(user_id: current_user.id, item_id: params[:item_id])
  end

end
