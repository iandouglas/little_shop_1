class Admin::UsersController < ApplicationController
before_action :require_admin

  def show
    # binding.pry
    @user = User.find(params[:id])
  end

  def index

  end

  def dashboard

  end
end
