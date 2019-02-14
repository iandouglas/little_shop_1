class SessionsController < ApplicationController

  def new
    if current_user
      flash[:error] = "You have already logged in"
      redirect_user
    end
  end

  def create
    if current_user
      flash[:error] = "You have already logged in"
      redirect_user
    else
      user = User.find_by_email(params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        flash[:success] = "You are now logged in"
        redirect_user
      else
        flash[:error] = "The given credentials were incorrect"
        render :new
      end
    end
  end

  def destroy
      session.clear
      flash[:success] = "You have successfully logged out"
      redirect_to root_path
  end

  private

  def redirect_user
    if admin_user?
      redirect_to root_path
    elsif merchant_user?
      redirect_to dashboard_path
    elsif regular_user?
      redirect_to profile_path
    end
  end
end
