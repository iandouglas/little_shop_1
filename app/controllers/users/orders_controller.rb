class Users::OrdersController < ApplicationController
  before_action :require_regular_user
  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    order = Order.new(user: current_user)
    @cart.contents.each do |item_id, quantity|
      OrderItem.new(order_id: order.id, item_id: item_id, quantity: quantity)
    end
    if order.save
      session[:cart].clear
      flash[:success] = 'Your order has been placed.'
      redirect_to profile_path
    end
  end
end
