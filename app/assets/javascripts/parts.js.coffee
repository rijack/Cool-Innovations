# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $("#part_part_process_ids").chosen()
  $('#part_part').chosen()
  $('#required_hardwares').find("select").chosen()
  $('#required-hardwares').bind 'insertion-callback', ->
    $('.hardware-cell tr.hide').removeClass()
    $('.req-hardware select').chosen()

