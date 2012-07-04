$(".order_line[data-id=<%= @order_line_process_status.order_line.id %>] span.status")
  .text <%= raw @order_line_process_status.order_line.status.to_json %>


$(".order_line[data-id=<%= @order_line_process_status.order_line.id %>]")
  .removeClass().addClass("order_line").addClass <%= raw @order_line_process_status.order_line.status.to_json.gsub(/\s+/, '-') %>