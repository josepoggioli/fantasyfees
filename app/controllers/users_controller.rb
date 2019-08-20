class UsersController < ApplicationController

  def new
    if flash[:warning] == "Invalid email or password"
      @alert_warning = true
      @alert_text = "Invalid email or password"
    end
  end

  def create
    user = User.new(
      username: params[:username],
      email: params[:email],
      first_name: params[:first_name],
      last_name: params[:last_name],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
      )
      if user.save
        session[:user_id] = user.id
        flash[:success] = "Successfully created account!"
        redirect_to "/landing"
      else
        flash[:warning] = "Invalid email or password"
        redirect_to "/signup"
      end
  end

  def show

  end

  def edit

  end

  def update
    if params[:current_password] && current_user.authenticate(params[:current_password])
      current_user.password = params[:password]
      current_user.password_confirmation = params[:password_confirmation]
      current_user.first_name = params[:first_name]
      current_user.last_name = params[:last_name]
      current_user.email = params[:email]
      if current_user.save
        flash[:primary] = "Password succesfully updated!"
        redirect_to "/users/#{current_user.id}"
      else
        flash[:warning] = "Problem occurred. Password was not updated."
        puts current_user.errors.full_messages
        redirect_to "/users/#{current_user.id}/edit"
      end
    elsif params[:current_password]
      flash[:warning] = "Current password does not match."
      redirect_to "/users/#{current_user.id}/edit"
    else
      current_user.first_name = params[:first_name]
      current_user.last_name = params[:last_name]
      current_user.email = params[:email]
      if current_user.save
        flash[:primary] = "User succesfully updated!"
        redirect_to "/users/#{current_user.id}"
      end
    end
  end

  def destroy
    current_user.destroy
    flash[:danger] = "User succesfully deleted!"
    redirect_to "/"
  end

end
