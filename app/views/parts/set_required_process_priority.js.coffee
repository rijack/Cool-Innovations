count = 0
$('.required_process_lines[data-id="<%= @curr_id%>"]').find(".required-process").each ->
  count += 1
  $(this).find(".sort_handle").text(count)
