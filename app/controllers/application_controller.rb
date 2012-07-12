class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :sort_column, :sort_direction, :sort_by_field


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
end
