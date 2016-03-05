class UsersController < ApplicationController
  skip_before_action :login_check, except: [:show]
  before_action :user_check, except: [:new, :create]

  def new
    @user = User.new
  end

  def show
    @user = User.find_by(id: session[:user_id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "welcome!"
      log_in(@user)
      redirect_to user_path(@user)
    else
      flash[:fail] = "One more!"
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end
end