class LeaguesController < ApplicationController
  
  def new
    if current_user
      if flash[:warning] == "There was an error with the user addition to the league."
        @alert_warning = true
        @alert_text = "There was an error with the user addition to the league."
      elsif flash[:warning] == "There was an error and the league was not created."
        @alert_warning = true
        @alert_text = "There was an error and the league was not created."
      elsif flash[:success] == "Successfully Logged in!"
        @alert_success = true
        @alert_text = "Successfully Logged in!"
      end
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
    if flash[:success] == "#{@league.name} league successfully created!"
      @alert_success = true
      @alert_text = "#{@league.name} league successfully created!"
    elsif flash[:success] == "Changes succesfully saved!"
      @alert_success = true
      @alert_text = "Changes succesfully saved!"
    elsif flash[:success] == "You have successfully joined the league!"
      @alert_success = true
      @alert_text = "You have successfully joined the league!"
    elsif flash[:success] == "Your payment has been submitted!"
      @alert_success = true
      @alert_text = "Your payment has been submitted!"
    end
  end

  def edit
    @league = League.find(params[:id])
  end

  def update
    if flash[:warning] == "Changes were not saved."
      @alert_warning = true
      @alert_text = "Changes were not saved."
    end
    @league = League.find(params[:id])
    @league.name = params[:name]
    @league.fee_due_date = params[:fee_due_date]
    @league.fee = params[:fee]
    if @league.save
      flash[:success] = "Changes succesfully saved!"
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
    if flash[:warning] == "There was an error adding you to the league."
      @alert_warning = true
      @alert_text = "There was an error adding you to the league."
    end
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
