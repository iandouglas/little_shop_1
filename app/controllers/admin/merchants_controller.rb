class Admin::MerchantsController < ApplicationController
  before_action :require_admin

  def show
    @user = User.find(params[:id])
    @orders = Order.for_merchant(@user.id)
    @items = @user.top_items_for_merchant(5)
    @states = @user.top_states_for_merchant(3)
    @cities = @user.top_cities_for_merchant(3)
    @top_user_by_orders = @user.top_user_by_orders(1)
    @top_user_by_items = @user.top_user_by_items(1)
    @top_users_by_price = @user.top_users_by_price(3)
  end

  def disable
    user = User.find(params[:id])
    if user.enabled?
      user.enabled = 'disabled'
      user.save
    end
    flash[:success] = "#{user.username} is now disabled"
    redirect_to merchants_path
  end

  def enable
    user = User.find(params[:id])
    if user.disabled?
      user.enabled = 'enabled'
      user.save
    end
    flash[:success] = "#{user.username} is now enabled"
    redirect_to merchants_path
  end
end
