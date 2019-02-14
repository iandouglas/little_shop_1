class Admin::Users::OrdersController < ApplicationController
  before_action :require_admin

  def index
    @orders = Order.where(user_id: params[:id])
    # binding.pry
  end
end
