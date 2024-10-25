class OrdersController < ApplicationController
  before_action :set_public_key, only: [:index, :create]
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :redirect_if_not_authorized, only: [:index, :create]
  

  

  def index
    @order_shipping = OrderShipping.new
  end

  
  def create
    @order_shipping = OrderShipping.new(order_params)
    if @order_shipping.valid?
      pay_item
      @order = Order.create(item_id: params[:item_id], user_id: current_user.id)
      @order_shipping.order_id = @order.id
      @order_shipping.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_shipping).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(item_id: params[:item_id], user_id: current_user.id, token: params[:token])
  end
  
  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def set_public_key
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_if_not_authorized
    # 自身が出品した商品の購入ページにアクセスしようとした場合、トップページにリダイレクト
    if @item.user_id == current_user.id
      redirect_to root_path
    end

    #売却済み商品の購入ページにアクセスしようとした場合、トップページにリダイレクト
    if @item.order.present? && @item.user_id != current_user.id
      redirect_to root_path
    end

  end
  
end
