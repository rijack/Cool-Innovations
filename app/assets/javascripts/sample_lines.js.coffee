# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('#sample_lines').live 'insertion-callback', ->
    $('#sample_lines').find("select").chosen(search_contains: true)
