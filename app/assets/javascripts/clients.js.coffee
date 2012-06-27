# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->
  $("#client_client").chosen()

  $('#modal-container').on 'shown', ->
    $.get "/clients/new?no_layout=1", (data) ->
      $("#modal-container").html data
