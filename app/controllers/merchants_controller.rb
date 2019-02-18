class MerchantsController<ApplicationController
  def index
    @merchants = User.where(role: 1, enabled: 0)
  end

end
