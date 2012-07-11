# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->
  $(".modal-trigger").click ->
    $("#modal-container .spinner").spin()
    url = $(this).attr('href')
    $("#modal-container").modal()
    $("#modal-container").on 'shown', ->
      $.get url, (data) ->
        $("#modal-container").html data
        $("#modal-container form:not(.filter) :input:visible:enabled:first").focus()
    return false


  $('.process_status .status').live 'change', ->
    $select = $(this)
    status = $select.val()
    process_status_id = $select.parents(".process_status").data("id")
    #console.log process_status_id
    #console.log status
    $.ajax
      type: 'POST'
      url: "/order_lines/set_process_status"
      data:
        status: status
        order_line_process_status_id: process_status_id


  $('.process_status .line-status .btn').live 'click', ->
    status = $(this).html()
    $(this).siblings().removeClass("btn-success").removeClass("btn-info").removeClass("btn-warning")
    if (status == 'completed')
      $(this).addClass("btn-success")
    else if (status == 'in progress')
      $(this).addClass("btn-info")
    else
      $(this).addClass("btn-warning")
    process_status_id = $(this).parents(".process_status").data("id")
    $.ajax
      type: 'POST'
      url: "/order_lines/set_process_status"
      data:
        status: status
        order_line_process_status_id: process_status_id


  $('.accordion-toggle').on "click", ->
    $(this).children().toggleClass("icon-plus").toggleClass("icon-minus");

  $('.collapse').on 'show', ->
    $(this).parent("td").removeClass("hide")


  $('.collapse').on 'hidden', ->
    $(this).parent("td").addClass("hide")

  currentEditable = ""
  $('.editable').live 'click', ->
    if (currentEditable == "")
      oldValue = $(this).html()
      currId = $(this).attr('id')
      postUrl = $(this).attr('data-headers')

      editableField= currId.split("-")[0]
      editableID = currId.split("-")[1]
      currentEditable = true
      inputType = "input"

      if (editableField == "quantity")
        $(this).html("<input type='text' id='"+$(this).attr('id')+"' value='"+oldValue+"'/>");
      else
        $(this).html("<textarea id='"+$(this).attr('id')+"'>"+oldValue+"</textarea>");
        inputType = "textarea"

      $("#"+currId+" "+inputType).focus()
      $("#"+currId+" "+inputType).on 'blur', ->
        newValue = $("#"+currId+" "+inputType).val()
        if (newValue != oldValue)
          $.ajax
            type: 'POST'
            url: postUrl
            data:
              field: editableField
              id: editableID
              new_value: newValue
          $(this).parents("td").html(newValue);
        else
          $(this).parents("td").html(oldValue);
        currentEditable = ""


  $(".ship-orders").click ->
    cBoxes = $('input.ship-lines')
    toShip = []
    cBoxes.filter(':checked').each ->
      orderLineId = $(this).val().split("-")[1]
      toShip.push orderLineId

    if (toShip.length > 0)
      $.ajax
        type: 'POST'
        url: "/order_lines/ship_order_lines"
        data:
          ids: toShip
    else
      alert("Select a line to ship, you dumbass!!!!")

    return false
