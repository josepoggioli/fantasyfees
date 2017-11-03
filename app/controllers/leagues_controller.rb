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

  def edit
    @league = League.find(params[:id])
  end

  def update
    @league = League.find(params[:id])
    @league.name = params[:name]
    @league.fee_due_date = params[:fee_due_date]
    @league.fee = params[:fee]
    if @league.save
      flash[:primary] = "Changes succesfully saved!"
      redirect_to "/leagues/#{@league.id}"
    else
      flash[:warning] = "Changes were not saved."
      render :edit
    end  
  end

  def destroy
    @league = League.find(params[:id])
    @league.destroy
    flash[:danger] = "League succesfully deleted!"
    redirect_to "/"
  end

  def invitation
    @league = League.find(params[:id])
  end  

  def join
  end

  def new_join
    input_league_code = params[:league_code]
    @league = League.find_by(league_code:input_league_code)
    league_user_ids = []
    @league.user_leagues.each do |user|
      league_user_ids << user.user_id
    end
    if league_user_ids.include? current_user.id
      flash[:warning] = "You have already joined this league."
      redirect_to '/'
    else
      user_league = UserLeague.new(
        user_id: current_user.id,
        league_id: @league.id,
        admin: false,
        fee_payed: false
      )
      if user_league.save
        flash[:success] = "You have successfully joined the league!"
        redirect_to "/leagues/#{@league.id}"
      else
        flash[:warning] = "There was an error adding you to the league."
        redirect_to "/leagues/join"
      end
    end
  end

  def generate_code(number)
    charset = Array('A'..'Z') + Array(1..9)
    Array.new(number) { charset.sample }.join
  end

end
