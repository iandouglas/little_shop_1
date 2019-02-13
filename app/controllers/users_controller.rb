class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "You've successfully registered your account"
      redirect_to profile_path(@user)
    else
      if User.find_by(email: @user.email)
        flash[:error] = "This E-mail is already registered"
        render :new
      else
        flash[:error] = "You are missing information"
        render :new
      end
    end
  end

  def show
    unless current_user
      render :file => './public/404.html', status: 404
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :street, :city, :state, :zip_code, :email, :password)
  end
end
