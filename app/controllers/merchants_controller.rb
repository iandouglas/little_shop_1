class MerchantsController<ApplicationController

  def index
    if admin_user?
      @merchants = User.where(role: 1)
    else
      @merchants = User.where(role: 1, enabled: 0)
      @fastest_fulfillers = User.fulfillment_times("desc")
      @slowest_fulfillers = User.fulfillment_times("asc")
      @most_sold = User.top_merchants_by_price_and_qty
      @top_states = User.top_shipped_states
    end
  end

end
