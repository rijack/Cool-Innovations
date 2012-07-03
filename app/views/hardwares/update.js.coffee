<% if @hardware.errors.empty? %>
  $(".modal-body").html "Hardware was updated"
  setTimeout (-> $('#modal-container').modal('hide')), 2000
  location.reload()
<% else %>
  $("#edit_hardware_<%= @hardware.id %>").replaceWith "<%= raw escape_javascript(render("hardwares/form")) %>"
<% end %>