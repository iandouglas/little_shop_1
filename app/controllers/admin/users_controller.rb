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
    if user.role == 'user'
      user[:role] = 1
      user.save
      flash[:success] = "#{user.username} is now a merchant"
      redirect_to admin_merchant_path(user.id)
    elsif user.role == 'merchant'
      user[:role] = 0
      user.save
      flash[:success] = "#{user.username} is now a user"
      redirect_to admin_user_path(user.id)
    end
  end

  def merchants
    @merchant = User.find(params[:id])
  end
end
