# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $("#part_part_process_ids").chosen(search_contains: true)

  $('#required_hardwares').find("select").chosen(search_contains: true)
  $('#required-hardwares').bind 'insertion-callback', ->
    $('.hardware-cell tr.hide').removeClass()
    $('.req-hardware select').chosen(search_contains: true)

  $('#part_part').chosen(search_contains: true).change 'on', ->
    $(".simple_form.part").submit()

