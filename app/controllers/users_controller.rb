class UsersController < ApplicationController

  before_action :set_user    , only: [:show, :edit, 
                                            :update, :destroy]
  before_action :user_params , only: [:create, :update]
  before_action :check_login , only: [:show, :edit, :update, 
                                             :destroy, :index]
  before_action :admin_auth  , only: [:delete]
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Account created successfully."
      log_in @user
      redirect_to @user
    else
      flash[:error] = "Failed to create account."
      render :new
    end
  end

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Account edited successfully."
      redirect_to @user 
    else
      flash[:error] = "Failed to edit account."
      redirect_to root_path
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "Selected account successfully deleted."
      redirect_to users_path
    else
      flash[:error] = "Failed to delete."
      redirect_to users_path
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def admin_auth
    redirect_to(root_url) unless current_user.admin?
  end

  def correct_user
    redirect_to(root_url) unless User.find(current_user.id) == User.find(params[:id])
  end

  def check_login
    redirect_to(root_url) unless logged_in?
  end

end
