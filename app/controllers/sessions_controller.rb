class SessionsController < ApplicationController
  skip_filter :needs_login

  def new
  end

  def index
    if current_user and current_user.status == "station"
      redirect_to index_floor_stations_path
    else
      redirect_to comments_path
    end
  end

  def create
    user = User.find_by_username(params[:user][:username]) ||
      User.find_by_email(params[:user][:username])

    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      session[:last_seen] = Time.now
      redirect_to root_url, notice: "Logged in!"
    else
      flash.now.alert = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end
end
