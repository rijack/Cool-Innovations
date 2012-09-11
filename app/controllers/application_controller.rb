class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :sort_column, :sort_direction, :sort_by_field, :current_user, :logged_in?

  before_filter :needs_login
  layout :application_layout

  protected
  def sort_direction
    if params[:direction]
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    else
      if cookies["order_line_sort_order"] != nil
        cookies["order_line_sort_order"].split(" ")[1]
      end
    end
  end

  def sort_column
    if params[:sort]
      params[:sort]
    else
      if cookies["order_line_sort_order"] != nil
        cookies["order_line_sort_order"].split(" ")[0]
      end
    end
  end

  def sort_by_field
    if params[:sort]
      "#{sort_column} #{sort_direction}"
    else
      if params[:controller] == "orders"
        cookies["order_line_sort_order"] != nil ? cookies["order_line_sort_order"] : "due_date asc"
      end
    end
  end

  def current_user
    @current_user ||= User.find_by_id session[:user_id]
  end

  def logged_in?
    session[:user_id] && !!current_user
  end

  def user_admin?
    current_user && current_user.admin?
  end

  def user_not_user?
    current_user && current_user.not_user?
  end

  def needs_login
    if !logged_in?
      redirect_to login_url, :notice => "you need to be logged in"
    else
      session_timeout
    end
  end

  def needs_admin
    if !user_admin?
      redirect_to login_url, :notice => "you need to be logged in as admin"
    else
      session_timeout
    end
  end

  def needs_not_user
    if !user_not_user?
      redirect_to login_url, :notice => "you need to be logged in as manager"
    else
      session_timeout
    end
  end

  def session_timeout
    if !session[:last_seen] || session[:last_seen] < 30.minutes.ago
      reset_session
      redirect_to login_url, :notice => "your session timed-out"
    end
    session[:last_seen] = Time.now
  end

  def application_layout
    current_user.try(:layout) || "application"
  end
end
