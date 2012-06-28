<% if @part_process.errors.empty? %>
$(".modal-body").html "Process was updated"
setTimeout (-> $('#modal-container').modal('hide')), 2000
location.reload()
<% else %>
$("#new_part_process").replaceWith "<%= raw escape_javascript(render("part_processes/form")) %>"
<% end %>