class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @orders = Order.all
  end

  def create
  end
  
end
