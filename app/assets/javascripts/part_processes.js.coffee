# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->
  $(".process_order_lines").sortable
    helper: (e, ui) ->
      ui.children().each -> $(this).width($(this).width())
      ui
    handle: '.sort_handle'
    update: (event, ui) ->
      $row = $(ui.item)
      order_line_ids = ($(row).data('id') for row in $row.parent().find(".order_line"))
      process_id = $row.parents("table").data("id")
      #console.log(process_id)
      
      $.ajax
        type: 'POST'
        url: "/part_processes/#{process_id}/set_order_line_priority"
        data:
          order_line_ids: order_line_ids
