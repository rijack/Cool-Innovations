count = 0
$('.process_order_lines[data-id="<%= @curr_id%>"]').find(".order_line").each ->
  count += 1
  $(this).find(".sort_handle").text(count)
