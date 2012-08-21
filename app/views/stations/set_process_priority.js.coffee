count = 0
$('.user-process-lines[data-id="<%= @curr_id%>"]').find(".user-process").each ->
  count += 1
  $(this).find(".sort_handle").text(count)
