# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->
  #$('#orders-table').tableScroll({height:500});
  $(".refresh").on 'click', ->
    location.reload()

  $(".orders #orders-table").stickyTableHeaders();
  $(".modal-trigger").click ->
    $("#modal-container .spinner").spin()
    url = $(this).attr('href')
    $("#modal-container").modal()
    $("#modal-container").on 'shown', ->
      $.get url, (data) ->
        $("#modal-container").html data
        $("#modal-container form:not(.filter) :input:visible:enabled:first").focus()
        $("#modal-container").find("select").chosen(search_contains: true)
    return false


  $('.process_status .status').live 'change', ->
    $select = $(this)
    status = $select.val()
    process_status_id = $select.parents(".process_status").data("id")
    $.ajax
      type: 'POST'
      url: "/order_lines/set_process_status"
      data:
        status: status
        order_line_process_status_id: process_status_id


  $('.process_status .line-status .btn').live 'click', ->
    console.log(1)
    status = $(this).attr("data-value")
    #console.log(status)
    $(this).siblings().removeClass("btn-success").removeClass("btn-info").removeClass("btn-warning").removeClass("btn-danger").removeClass("btn-primary")
    if (status == 'completed')
      $(this).addClass("btn-success")
    else if (status == 'in progress')
      $(this).addClass("btn-info")
    else if (status == 'assigned')
      $(this).addClass("btn-danger")
    else if (status == 'verified')
      $(this).addClass("btn-primary")
      ###if document.location.pathname == "/stations"
        location.reload()###
    else
      $(this).addClass("btn-warning")
      if document.location.pathname == "/orders"
        $(this).parents("td").siblings(".assigned-users").find(".assign-user").val(0).trigger("liszt:updated")
      ###else if document.location.pathname == "/stations"
        location.reload()###

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
    headers = $(this).attr("data-headers")
    if headers
      $this = $(this).html('<div />')
      $.ajax
        type: 'GET'
        url: headers
        success: (data) => $this.html(data).removeAttr("style")


  $('.collapse').on 'hidden', ->
    $(this).parent("td").addClass("hide")

  currentEditable = ""
  $('.editable').live 'click', ->
    if (currentEditable == "")
      substrLength = $(this).attr('data-substr')
      tag = $(this)
      if ($(this).attr('data-content'))
        oldValue = $(this).attr('data-content')
      else
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


          if (substrLength)
            if (newValue.length > substrLength-3)
              modifiedValue = newValue.substr(0,substrLength-3)+ "..."
            else
              modifiedValue = newValue
            tag.attr('data-content',newValue)
          else
            modifiedValue = newValue
            tag.attr('data-content',newValue)

          $(this).parent("td").html(modifiedValue);
        else
          if (substrLength)
            if (oldValue.length > substrLength-3)
              modifiedValue = oldValue.substr(0,substrLength-3)+ "..."
            else
              modifiedValue = oldValue
            tag.attr('data-content',oldValue)
          else
            modifiedValue = oldValue
          $(this).parent("td").html(modifiedValue);
        currentEditable = ""

  $(".show-all").on 'click', ->
    current_id = $(this).attr("data-id")
    console.log()
    $("tr[data-id="+current_id+"].collapsible").toggleClass("no-orders").toggleClass("has-orders");
    return false


  $(".show-hide").on 'click', ->
    $(this).children().toggleClass("icon-plus").toggleClass("icon-minus");
    block_id = $(this).attr("data-id")
    $("#"+block_id).toggleClass("show-hide-container in").toggleClass("show-hide-container");
    $("#"+block_id).parents(".attached").toggleClass("no-display").toggleClass("");

    type = block_id.split("-")[0]
    id = block_id.split("-")[1]
    current_status = ($("#"+block_id).hasClass("in")) ? true : false

    if type == "station"
      curr_url = "/stations/update_station"
    else if type == "user"
      curr_url = "/users/update_user"

    $.ajax
      type: 'POST'
      url: curr_url
      data:
        field: "station_display"
        id: id
        new_value: current_status
    return false
