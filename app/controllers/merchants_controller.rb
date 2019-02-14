class MerchantsController<ApplicationController

  def index
    if admin_user?
      @merchants = User.where(role: 1)
    else
      @merchants = User.where(role: 1, enabled: 0)
      @most_sold = User.top_merchants_by_price_and_qty
    end
  end

end
