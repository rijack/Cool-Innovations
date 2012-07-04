module ApplicationHelper
  def sortable column, title = nil
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

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
