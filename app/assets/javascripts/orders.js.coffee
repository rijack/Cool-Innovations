# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  # hack to save date from: http://railscasts.com/episodes/213-calendars?view=comments
  datePicker = (selector) ->
    $real = $(selector).not(".picked")
    $real.addClass("picked")
    $real.datepicker({dateFormat: 'mm/dd/y'})

  $('#search_form').find("select").chosen(search_contains: true)
  $('#search_form .datepicker').datepicker({dateFormat: 'mm/dd/y'})
  $("#order_client_id").chosen(search_contains: true)
  $('#order_lines').find("select").chosen(search_contains: true)
  datePicker $(".due-date")
  datePicker $(".ship-date")
  isDuplicate = false

  # duplicating line call
  $('.duplicate-line').on 'click', ->
    isDuplicate = true
    $(".add-line").click()
    return false

  # adding line method
  $('#order_lines').bind 'insertion-callback', ->
    $('#order_lines').find("select").chosen(search_contains: true)
    datePicker $(".due-date")
    datePicker $(".ship-date")

    # duplicate line if needed
    if (isDuplicate)
      lines_length = $(this).children(".nested-fields").length
      if (lines_length > 1)
        copy_from = $(this).children(".nested-fields:nth-child("+lines_length+")")
        copy_to = $(this).children(".nested-fields:nth-child("+(lines_length+1)+")")

        $(copy_from).find("input, select, textarea").each ->
          curr_id = $(this).attr('id')
          if (curr_id != undefined)
            curr_value = $(this).val()
            last_two = curr_id.split("_")[curr_id.split("_").length-2]
            last = curr_id.split("_")[curr_id.split("_").length-1]
            if (! /^[a-zA-Z]+$/.test(last_two))
              test_id = last
            else
              test_id = last_two + "_" + last

            copy_to.find('[id$='+test_id+']').val(curr_value)
            $("select").trigger("liszt:updated")
    isDuplicate = false


  # automatic due and ship date setting
  $(".due-date").live 'change', ->
    udpateShipDate (this)

  $(".shipping-method").live 'change', ->
    udpateShipDate (this)


  udpateShipDate = (line) ->
    currParent = $(line).parents("td")
    shipDateCell = $($(currParent).siblings(".ship-date-cell")).find(".ship-date")
    if (line.tagName == "INPUT")
      dueDateValue = Date.parse($(line).val())
      selectGroup = $($(currParent).siblings(".shipping-method-cell")).find(".shipping-method")
      durationValue = $(selectGroup).find(":selected").attr("data-duration")
    else
      dueDateValue = Date.parse($($(currParent).siblings(".due-date-cell")).find(".due-date").val())
      durationValue = $(line).find(":selected").attr("data-duration")

    if (durationValue && dueDateValue)
      shipDate = dueDateValue.add({days:-durationValue})
      shipDateCell.val(shipDate.toString("MM/dd/yy"))


  $(".ship-orders").click ->
    cBoxes = $('input.ship-lines')
    toShip = []
    cBoxes.filter(':checked').each ->
      orderLineId = $(this).val().split("-")[1]
      toShip.push orderLineId

    if (toShip.length > 0)
      $.ajax
        type: 'POST'
        url: "/order_lines/update_order_lines"
        data:
          ids: toShip
          field: 'status'
          value: 'shipped'
    else
      alert("Select a line to ship, you dumbass!!!!")

    return false


  $(".unship").on "click", ->
    orderLineId = $(this).attr('data-id')
    $.ajax
      type: 'POST'
      url: '/order_lines/reset_order_line_status'
      data:
        id: orderLineId
    return false

  $(".change-color").on "click", ->
    cBoxes = $('input.ship-lines')
    colorValue = $(this).attr("data-sort")+"-"+$(this).html()
    colorValues = []
    toChange = []

    $(this).parents("li").siblings().each ->
      colorValues.push $(this).children("a").attr("data-sort")+"-"+$(this).children("a").html()

    console.log(colorValues)
    cBoxes.filter(':checked').each ->
      orderLineId = $(this).val().split("-")[1]
      $(this).attr('checked', false)
      toChange.push orderLineId
      for value in colorValues
        $(".order_line[data-id="+orderLineId+"]").removeClass(value)
      $(".order_line[data-id="+orderLineId+"]").addClass(colorValue)

    $.ajax
      type: 'POST'
      url: "/order_lines/update_order_lines"
      data:
        ids: toChange
        field: 'color'
        value: colorValue
    $('.dropdown').removeClass('open');
    return false


  window.update_search_dropdowns = ->
    data =
      client_id: $("#search_form #search_client").val()
      order_id: $("#search_form #search_po_number").val()
      part_id: $("#search_form #search_part_id").val()
      display: $("#search_form").data('display')
    $.ajax
      type: 'POST'
      url: "/orders/update_search_dropdowns"
      data: data

  $("#search_form #search_client").change update_search_dropdowns
  $("#search_form #search_part_id").change update_search_dropdowns
  $("#search_form #search_po_number").change update_search_dropdowns
