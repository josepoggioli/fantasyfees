class UserLeaguesController < ApplicationController

  def show
     @user_league = UserLeague.find(params[:id])
  end

  def edit
    @user_league = UserLeague.find(params[:id])
    @user_league.fee_payed = !@user_league.fee_payed
    if @user_league.save
      flash[:success] = "Payment confirmed!"
      redirect_to "/user_leagues/#{@user_league.id}" 
    else
      flash[:warning] = "Payment did not get change"
      redirect_to "/user_leagues/#{@user_league.id}" 
    end
  end

  def delete 
    user_league = UserLeague.find(params[:id])
    league = user_league.league 
    user_league.destroy
    flash[:danger] = "User succesfully removed from league!"
    redirect_to "/leagues/#{league.id}"
  end
  
end
