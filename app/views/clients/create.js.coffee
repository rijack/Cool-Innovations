<% if @client.errors.empty? %>
  $(".modal-body").html "Client was created"
  setTimeout (-> $('#modal-container').modal('hide')), 2000
  location.reload()
<% else %>
  $("#new_client").replaceWith "<%= raw escape_javascript(render("clients/form")) %>"
<% end %>
