class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @item = Item.find(params[:item_id])
    @order_shipping = OrderShipping.new
  end

  
  def create
    @order_shipping = OrderShipping.new(order_params)
    if @order_shipping.valid?
      @order = Order.create(item_id: params[:item_id], user_id:current_user.id)
      @order_shipping.order_id = @order.id
      @order_shipping.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_shipping).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(item_id: params[:item_id], user_id: current_user.id)
  end

  
end
