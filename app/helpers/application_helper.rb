module ApplicationHelper
  def sortable column, title = nil
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"

    i_class = "con-chevron-down"
    if sort_direction == "asc"
      i_class = "con-chevron-up"
    end

    link_to({:sort => column, :direction => direction, :search => params[:search]}, {:class => css_class}) do
      tag(:i, :class=> i_class) + " " + title
    end
  end
end
