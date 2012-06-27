<% if @client.errors.empty? %>
  $(".modal-body").html "Client was updated"
  setTimeout (-> $('#modal-container').modal('hide')), 2000
<% else %>
  $("#edit_client_<%= @client.id %>").replaceWith "<%= raw escape_javascript(render("clients/form")) %>"
<% end %>