class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :sort_column, :sort_direction, :sort_by_field, :current_user, :logged_in?

  before_filter :needs_login

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
      if cookies["order_line_sort_order"] != nil && params[:controller] == "orders"
        cookies["order_line_sort_order"]
      else
        "ship_date asc"
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

  def needs_login
    if !logged_in?
      redirect_to login_url, :notice => "you need to be logged in"
    end
  end

  def needs_admin
    if !user_admin?
      redirect_to login_url, :notice => "you need to be logged in as admin"
    end
  end
end
