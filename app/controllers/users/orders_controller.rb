class Users::OrdersController < ApplicationController
  before_action :require_regular_user
  def index
    @orders = current_user.orders
  end
end
