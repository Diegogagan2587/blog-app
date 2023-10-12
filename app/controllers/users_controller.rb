class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    # redirect to log_out acction if id = sing_out
    if params[:id] == 'sign_out'
      log_out
    else
      @user = User.find(params[:id])
    end
  end

  # def a method to handle log_out
  def log_out
    # sign_out is a method from devise
    sign_out current_user
    redirect_to new_user_session_path
  end
end
