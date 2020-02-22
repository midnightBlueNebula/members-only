class UsersController < ApplicationController

  before_action :set_user   , only: [:show, :edit, 
                                            :update, :destroy]
  before_action :user_params, only: [:create, :update]
  before_action :admin_auth , only: [:delete]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Account created successfully."
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

    else
      
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
  end

end
