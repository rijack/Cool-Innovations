# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $(".hardware_category_sort").sortable
    helper: (e, ui) ->
      ui.children().each -> $(this).width($(this).width())
      ui
    handle: '.sort_handle'
    update: (event, ui) ->
      $row = $(ui.item)
      ids = ($(row).data('id') for row in $row.parent().find(".hardware_category"))
      #console.log(process_id)
      
      $.ajax
        type: 'POST'
        url: "/hardware_categories/set_sort_priority"
        data:
          ids: ids

$ ->
  $(".part_process_category_sort").sortable
    helper: (e, ui) ->
      ui.children().each -> $(this).width($(this).width())
      ui
    handle: '.sort_handle'
    update: (event, ui) ->
      $row = $(ui.item)
      ids = ($(row).data('id') for row in $row.parent().find(".part_process_category"))
      #console.log(process_id)
      
      $.ajax
        type: 'POST'
        url: "/part_process_categories/set_sort_priority"
        data:
          ids: ids
