class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "You've successfully registered your account and logged in"
      redirect_to profile_path
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

  def edit
    which_user
  end

  def update
    which_user
    if profile_params[:password] == ""
      new_params = profile_params.except(:password)
      @user.update(new_params)
    elsif profile_params[:password]
      @user.update(profile_params)
    end
    if @user.save
      if admin_user?
        redirect_to admin_user_path(@user)
      elsif regular_user?
        redirect_to profile_path
      end
    else
      flash[:error] = "This should be error block messages"
      render :edit
    end
  end

  def profile
      render :file => './public/404.html', status: 404 unless regular_user?
  end

  def dashboard
    render :file => './public/404.html', status: 404 unless merchant_user?
    if current_user
      @orders = Order.for_merchant(current_user.id)
      @items = User.find(current_user.id).top_items_for_merchant(5)
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :street, :city, :state, :zip_code, :email, :password)
  end

  def profile_params
  params.require(:profile).permit(:username, :street, :city, :state, :zip_code, :email, :password, :confirm_password)
  end

  def which_user
    if admin_user?
      @user = User.find(params[:user_id])
    else
      @user = current_user
    end
  end

end
