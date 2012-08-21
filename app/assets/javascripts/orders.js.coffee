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

  $(".ship-date").live 'change', ->
    udpateShipDate (this)


  udpateShipDate = (line) ->
    curr_parent = $(line).parents("td")
    current = $(curr_parent).attr('class')
    part_number_cell = $($(curr_parent).siblings(".part-number-cell"))

    ship_date_cell = $($(part_number_cell).siblings(".ship-date-cell")).find(".ship-date")
    due_date_cell = $($(part_number_cell).siblings(".due-date-cell")).find(".due-date")

    ship_date_value = Date.parse(ship_date_cell.val())
    due_date_value = Date.parse(due_date_cell.val())
    duration_value = $($(part_number_cell).siblings(".shipping-method-cell")).find(".shipping-method").find(":selected").attr("data-duration")

    if due_date_value
      new_ship_date = due_date_value.add({days:-duration_value})

    if ship_date_value
      new_due_date = ship_date_value.add({days:duration_value})

    if current == "shipping-method-cell"
      if due_date_value
        ship_date_cell.val(new_ship_date.toString("yyyy-MM-dd"))

    if current == "due-date-cell"
      ship_date_cell.val(new_ship_date.toString("yyyy-MM-dd"))

    if current == "ship-date-cell"
      due_date_cell.val(new_due_date.toString("yyyy-MM-dd"))


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

  # submitting search on select change
  $("#search_form select").on "change", ->
    $("#search_form").submit()

  $('tr.order_line a.order-toggle').click ->
    console.log "this"
    return false

  $('.create-plus').click ->
    $("#success-type").val("plus")
    $("#new_order").submit()
    return false;


  $(".assign-user").live 'change', ->
    selected_user = parseInt($(this).val())
    order_line_process_id = $(this).parents("td").attr("data-id")
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
