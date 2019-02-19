class Admin::Users::OrdersController < ApplicationController
  def index
    @orders = Order.where(user_id: params[:id])
    # binding.pry
  end
end
