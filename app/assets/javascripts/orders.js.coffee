# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  # hack to save date from: http://railscasts.com/episodes/213-calendars?view=comments
  datePicker = (selector) ->
    $real = $(selector)
    $display = $real.clone().attr({class: null, id: null, name: null})
    $real.hide()
    $display.insertBefore($real)
    $display.datepicker({altField: $real, altFormat: 'yy-mm-dd'})

  $("#order_client_id").chosen()
  $('#order_lines').find("select").chosen()
  $('#order_lines').bind 'insertion-callback', ->
    $('#order_lines').find("select").chosen()

  datePicker $(".jquery-ui-date")

