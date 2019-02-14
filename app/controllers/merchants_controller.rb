class MerchantsController<ApplicationController

  def index
    if admin_user?
      @merchants = User.where(role: 1)
      stats_loader
    else
      @merchants = User.where(role: 1, enabled: 0)
      stats_loader
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
