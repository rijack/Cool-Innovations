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


  $(".required_process_lines").sortable
    helper: (e, ui) ->
      ui.children().each -> $(this).width($(this).width())
      ui
    handle: '.sort_handle'
    update: (event, ui) ->
      $row = $(ui.item)
      part_process_ids = ($(row).data('id') for row in $row.parent().find(".required-process"))
      part_id = $row.parents("table").data("id")
      console.log(part_process_ids)

      $.ajax
        type: 'POST'
        url: "/parts/#{part_id}/set_required_process_priority"
        data:
          part_process_ids: part_process_ids

