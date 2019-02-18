class Users::OrdersController < ApplicationController
  before_action :require_regular_user
  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @cart.checkout_order
    redirect_to profile_path
  end
end
