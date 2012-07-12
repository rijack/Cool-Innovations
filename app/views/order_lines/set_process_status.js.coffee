<% unless @order_line_process_status.errors.present? %>
$(".order_line[data-id=<%= @order_line_process_status.order_line.id %>] td.actions")
  .removeClass().addClass("actions fixed").addClass <%= raw @order_line_process_status.order_line.status.to_json.gsub(/\s+/, '-') %>

$(".order_line[data-id=<%= @order_line_process_status.order_line.id %>] span.status").attr('title', <%= raw @order_line_process_status.order_line.status.to_json %>)
<% else %>
  # TODO: Ron, display some kind of error here?
<% end %>
