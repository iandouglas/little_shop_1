class Admin::MerchantsController < ApplicationController
  before_action :require_admin

  def show
    @merchant = User.find(params[:id])
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

  # def enable
  #   user = User.find(params[:id])
  #   if user.disabled?
  #     user.enabled = 'enabled'
  #     user.save
  #   end
  #   flash[:success] = "#{user.username} is now enabled"
  #   redirect_to admin_users_path
  # end
end
