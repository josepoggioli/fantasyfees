class UserLeaguesController < ApplicationController

  def show
     @user_league = UserLeague.find(params[:id])
  end

  def edit
    @user_league = UserLeague.find(params[:id])
    payment = Payment.new(
      amount: params[:amount].to_i*100,
      user_league_id: params[:user_league_id]
    )

    if (@user_league.league.fee - @user_league.total_payments) - (payment.amount/100) < 0
      flash[:warning] = "The payment is larger than the user's balance. Please try the payment again."
      redirect_to "/user_leagues/#{@user_league.id}"
    else
      if payment.save
        flash[:success] = "Payment confirmed!"
        redirect_to "/user_leagues/#{@user_league.id}"
      else
        flash[:warning] = "Payment did not get change"
        redirect_to "/user_leagues/#{@user_league.id}" 
      end
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
