class UsersController < ApplicationController
  before_action :check_logged_in_or_redirect, except: [:new, :create]

  def new
    redirect_to home_path if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to home_path
    else
      render :new
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @queue_items = @user.queue_items || []
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :full_name)
  end
end
