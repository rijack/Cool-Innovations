module ApplicationHelper
  def sortable column, title = nil
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"

    i_class = "icon-chevron-down"
    if sort_direction == "asc"
      i_class = "icon-chevron-up"
    end

    link_to({:sort => column, :direction => direction, :search => params[:search]}, {:class => css_class}) do
      raw ("#{content_tag(:i, "", :class=> i_class).html_safe if css_class} " + title)
    end
  end

  def nonsortable column, title = nil
    title ||= column.titleize
  end

  def display_date input_date
    return input_date.strftime("%d-%b-%y")
  end
end
