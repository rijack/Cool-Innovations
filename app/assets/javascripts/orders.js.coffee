# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  # hack to save date from: http://railscasts.com/episodes/213-calendars?view=comments
  datePicker = (selector) ->
    $real = $(selector).not(".picked")
    $real.addClass("picked")
    $real.datepicker({dateFormat: 'yy-mm-dd'})

  $('#search_form').find("select").chosen(search_contains: true)
  $('#search_form .datepicker').datepicker({dateFormat: 'yy-mm-dd'})
  $("#order_client_id").chosen(search_contains: true)
  $('#order_lines').find("select").chosen(search_contains: true)


  $('#order_lines').bind 'insertion-callback', ->
    $('#order_lines').find("select").chosen(search_contains: true)
    datePicker $(".due-date")
    datePicker $(".ship-date")

  datePicker $(".due-date")
  datePicker $(".ship-date")

  $(".due-date").live 'change', ->
    udpateShipDate (this)

  $(".shipping-method").live 'change', ->
    udpateShipDate (this)


  udpateShipDate = (line) ->
    currParent = $(line).parents("td")
    shipDateCell = $($(currParent).siblings(".ship-date-cell")).find(".ship-date")
    if (line.tagName == "INPUT")
      dueDateValue = Date.parse($(line).val())
      durationValue = $($(currParent).siblings(".shipping-method-cell")).find(".shipping-method").val()
    else
      dueDateValue = Date.parse($($(currParent).siblings(".due-date-cell")).find(".due-date").val())
      durationValue = $(line).val()

    if (durationValue && dueDateValue)
      shipDate = dueDateValue.add({days:-durationValue})
      shipDateCell.val(shipDate.toString("yyyy-MM-dd"))


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


  $(".assign-user").on 'change', ->
    selected_user = parseInt($(this).val())
    order_line_process_id = $(this).parents("tr").attr("data-id")
    console.log(order_line_process_id)
    if (selected_user == 0)
      $(".process_status[data-id="+order_line_process_id+"] td.process-statuses div button").removeClass().addClass("btn btn-small")
      $(".process_status[data-id="+order_line_process_id+"] td.process-statuses div button:nth-child(1)").addClass("btn-warning active")
    else
      $(".process_status[data-id="+order_line_process_id+"] td.process-statuses div button").removeClass().addClass("btn btn-small")
      $(".process_status[data-id="+order_line_process_id+"] td.process-statuses div button:nth-child(2)").addClass("btn-danger active")

    data =
      user_id: selected_user
      order_line_process_status_id: order_line_process_id
    $.ajax
      type: 'POST'
      url: "/order_lines/assign_user"
      data: data