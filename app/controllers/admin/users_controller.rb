class Admin::UsersController < ApplicationController
before_action :require_admin

  def show
    @user = User.find(params[:id])
  end

  def index

  end

  def dashboard

  end

  def update
    user = User.find(params[:user_id])
    if user.role == 'user'
      user[:role] = 1
      user.save
      flash[:success] = "#{user.username} is now a merchant"
      redirect_to admin_merchants_path(user.id)
    end
  end

  def merchants

  end
end
