class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @orders = Order.all
  end

  def new
    @order_shipping = OrderShipping.new
  end

  def create
    @order_shipping = OrderShipping.new(order_params)
    if @order_shipping.valid?
      @order_shipping.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_shipping).permit(:postcord, :prefecture_id, :municipalities, :street, :building, :telephone_number).merge(order_id: @order.id)
  end

  
end
