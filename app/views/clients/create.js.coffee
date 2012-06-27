<% if @client.errors.empty? %>
  $("#new_client").html "Client was created"
  setTimeout (-> $('#modal_container').modal('hide')), 1000
<% else %>
  $("#new_client").replaceWith "<%= raw escape_javascript(render("clients/form")) %>"
<% end %>
