class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

 
  def authenticate_user!
    unless current_user
    flash[:warning] = "You must login in order to continue."
    redirect_to '/login' 
    end
  end
  
end
