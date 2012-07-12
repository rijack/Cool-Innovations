# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  # hack to save date from: http://railscasts.com/episodes/213-calendars?view=comments
  datePicker = (selector) ->
    $real = $(selector).not(".picked")
    $real.addClass("picked")
    $real.datepicker({dateFormat: 'yy-mm-dd'})

  $('#search_form').find("select").chosen()
  $("#order_client_id").chosen()
  $('#order_lines').find("select").chosen()


  $('#order_lines').bind 'insertion-callback', ->
    $('#order_lines').find("select").chosen()
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
    console.log(2)
    cBoxes = $('input.ship-lines')
    colorValue = $(this).html()
    colorValues = []
    toChange = []

    $(this).parents("li").siblings().each ->
      colorValues.push $(this).children("a").html()

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

