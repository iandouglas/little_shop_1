class MerchantsController<ApplicationController

  def index
    if admin_user?
      @merchants = User.where(role: 1)
    else
      @merchants = User.where(role: 1, enabled: 0)
    end
  end

end
