class MerchantsController < ApplicationController

  def index
    if admin_user?
      @merchants = User.where(role: 1)
      stats_loader
    else
      @merchants = User.where(role: 1, enabled: 0)
      stats_loader
    end
  end
  
  def dashboard
   render :file => './public/404.html', status: 404 unless merchant_user?
   if current_user
     @orders = Order.for_merchant(current_user.id)
     @user = User.find(current_user.id)
     @items = @user.top_items_for_merchant(5)
     @states = @user.top_states_for_merchant(3)
     @cities = @user.top_cities_for_merchant(3)
     @top_user_by_orders = @user.top_user_by_orders(1)
     @top_user_by_items = @user.top_user_by_items(1)
     @top_users_by_price = @user.top_users_by_price(3)
    end
  end
  
private

  def stats_loader
    @fastest_fulfillers = User.fulfillment_times("desc")
    @slowest_fulfillers = User.fulfillment_times("asc")
    @most_sold = User.top_merchants_by_price_and_qty
    @top_states = User.top_shipped_states
    @top_cities = User.top_shipped_cities
    @largest_orders = Order.top_biggest_orders
  end
end
