count = 0
$('.hardware_category_sort').find(".hardware_category").each ->
  count += 1
  $(this).find(".sort_handle").text(count)
