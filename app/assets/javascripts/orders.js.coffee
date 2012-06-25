# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $("#order_client_id").chosen()
  $('#order_lines').find("select").chosen()
  $('#order_lines').bind 'insertion-callback', ->
    $('#order_lines').find("select").chosen()
