class SessionsController < ApplicationController

  def new 

  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Successfully Logged in!"
      redirect_to "/landing"
    else
      flash[:warning] = "Invalid email or password."
      redirect_to "/login"
    end
  end

  def destroy
    session[:user_id] = nil 
    flash[:success] = "Successfully logged out."
    redirect_to "/"
  end

end
