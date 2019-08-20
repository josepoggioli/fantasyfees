class SessionsController < ApplicationController

  def new 
    if flash[:warning] == "You need to sign in to be able to create a league."
      @alert_warning = true
      @alert_text = "You need to sign in to be able to create a league."
    elsif flash[:warning] == "Invalid email or password."
      @alert_warning = true
      @alert_text = "Invalid email or password."
    end
    @create_league = false
    if flash[:warning]== "You need to sign in to be able to create a league."
      @create_league = true
    end
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Successfully Logged in!"
      if params[:create_league] == "true" 
        redirect_to "/leagues/new"
      else 
        redirect_to "/"
      end
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
