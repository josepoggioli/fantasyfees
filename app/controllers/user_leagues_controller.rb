class UserLeaguesController < ApplicationController

  def payment
    @league = League.find(params[:id])
  end
  
end
