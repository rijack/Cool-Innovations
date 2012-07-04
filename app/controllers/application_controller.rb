class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :sort_column, :sort_direction, :sort_by_field


  protected
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def sort_column
    params[:sort]
  end

  def sort_by_field
    if sort_column
      "#{sort_column} #{sort_direction}" 
    else
      ""
    end
  end
end
