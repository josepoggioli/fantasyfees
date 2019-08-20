class PagesController < ApplicationController

  def index
    if current_user
      if flash[:danger] == "League succesfully deleted!"
        @alert_danger = true
        @alert_text = "League succesfully deleted!"
      elsif flash[:warning] == "You have already joined this league."
        @alert_warning = true
        @alert_text = "You have already joined this league."
      elsif flash[:success] == "Successfully Logged in!"
        @alert_success = true
        @alert_text = "Successfully Logged in!"
      elsif flash[:danger] == "User succesfully deleted!"
        @alert_danger = true
        @alert_text = "User succesfully deleted!"
      end
      render 'landing.html.erb'
    else
      if flash[:success] == "Successfully logged out."
        @alert_success = true
        @alert_text = "Successfully logged out."
      end
      @hide_container = true
      render 'index.html.erb'
    end
  end

  def landing
    if flash[:success] == "Successfully created account!"
      @alert_success = true
      @alert_text = "Successfully created account!"
    end
  end
  
end
