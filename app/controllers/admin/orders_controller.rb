class Admin::OrdersController < ApplicationController
  before_action :require_admin

  def show
    @order = Order.find_by(user_id: params[:id])
  end


end
