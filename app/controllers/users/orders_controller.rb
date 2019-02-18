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
    if order.save
      @cart.contents.each do |item_id, quantity|
        current_price = Item.find(item_id).price * quantity
        order.order_items.create(item_id: item_id, quantity: quantity, current_price: current_price)
      end
      session[:cart].clear
      flash[:success] = 'Your order has been placed.'
      redirect_to profile_path
    end
  end
end
