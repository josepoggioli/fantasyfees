class LeaguesController < ApplicationController

  def new
    if current_user
      render 'new.html.erb'
    else
      flash[:warning] = "You need to sign in to be able to create a league."
      redirect_to '/login'
    end
  end

  def create 
    @league = League.new(
     name: params[:name],
     fee_due_date: params[:fee_due_date],
     fee: params[:fee],
     league_code: generate_code(10) 
    )
    if @league.save
      user_league = UserLeague.new(
        user_id: current_user.id,
        league_id: @league.id,
        admin: true,
        fee_payed: false
      )
      if user_league.save
        flash[:success] = "#{@league.name} league successfully created!"
        redirect_to "/leagues/#{@league.id}"
      else
        flash[:warning] = "There was an error with the user addition to the league."
        redirect_to "/leagues/new"
      end
    else
      flash[:warning] = "There was an error and the league was not created."
      puts @league.errors.full_messages
      redirect_to "/leagues/new"
    end
  end

  def show
    @league = League.find(params[:id])
  end

  def generate_code(number)
    charset = Array('A'..'Z') + Array('a'..'z')
    Array.new(number) { charset.sample }.join
  end

end
