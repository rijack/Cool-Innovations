# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $(".user-process-lines").sortable
    helper: (e, ui) ->
      ui.children().each -> $(this).width($(this).width())
      ui
    handle: '.sort_handle'
    update: (event, ui) ->
      $row = $(ui.item)
      process_line_ids = ($(row).data('id') for row in $row.parent().find(".user-process"))
      user_id = $row.parents("table").data("id")
      #console.log(user_id)

      $.ajax
        type: 'POST'
        url: "/users/#{user_id}/set_process_priority"
        data:
          process_line_ids: process_line_ids