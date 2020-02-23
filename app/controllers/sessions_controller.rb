class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password]) && !logged_in?
      log_in @user 
      flash[:success] = "Logged in."
      redirect_to @user 
    else 
      flash[:error] = "Failed to log in."
      redirect_to root_path 
    end
  end

  def destroy
    log_out @user if logged_in?
    redirect_to root_path
  end

end
