class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @orders = Order.all
  end

  def create
    @order = Order.create(order_params)
    Shipping.create(shipping_params)
    redirect_to root_path
  end

  private

  def order_params
    params.merge(user_id: current_user.id)
  end

  def shipping_params
    params.permit(:postcord, :prefecture_id, :municipalities, :street, :building, :telephone_number).merge(order_id: @order.id)
  end

end
