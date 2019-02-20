class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_cart

  helper_method :current_user, :regular_user?, :merchant_user?, :admin_user?, :merchant_or_admin?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def regular_user?
    current_user && current_user.user?
  end

  def merchant_user?
    current_user && current_user.merchant?
  end

  def admin_user?
    current_user && current_user.admin?
  end

  def merchant_or_admin?
    merchant_user? || admin_user?
  end

  def require_admin
    render :file => './public/404.html', status: 404 unless admin_user?
  end

  def require_regular_user
    render :file => './public/404.html', status: 404 unless regular_user?
  end

  def set_cart
    @cart ||= Cart.new(session[:cart])
  end
end
