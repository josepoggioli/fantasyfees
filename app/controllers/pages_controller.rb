class PagesController < ApplicationController

  def index
    if current_user
      render 'landing.html.erb'
    else
      render 'index.html.erb'
    end
  end

  def landing
    
  end
  
end
