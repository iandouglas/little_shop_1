class Admin::UsersController < ApplicationController
before_action :require_admin

  def show
    @user = User.find(params[:id])
    if @user.role == 'merchant'
      redirect_to admin_merchant_path(@user)
    end
  end

  def index
    @users = User.where(role: 'user')
  end

  def dashboard

  end

  def update
    user = User.find(params[:user_id])
    if user.user?
      user[:role] = 1
      user.save
      flash[:success] = "#{user.username} is now a merchant"
      redirect_to admin_merchant_path(user.id)
    elsif user.merchant?
      items = Item.where(user_id: user.id)
      items.each do |item|
        item.disable_item
      end
      user[:role] = 0
      user.save
      flash[:success] = "#{user.username} is now a user"
      redirect_to admin_user_path(user.id)
    end
  end

  def disable
    user = User.find(params[:id])
    if user.enabled?
      user.enabled = 'disabled'
      user.save
    end
    flash[:success] = "#{user.username} is now disabled"
    redirect_to admin_users_path
  end

  def enable
    user = User.find(params[:id])
    if user.disabled?
      user.enabled = 'enabled'
      user.save
    end
    flash[:success] = "#{user.username} is now enabled"
    redirect_to admin_users_path
  end

  def merchants
    @merchant = User.find(params[:id])
  end
end
