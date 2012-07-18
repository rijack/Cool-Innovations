count = 0
$('.part_process_category_sort').find(".part_process_category").each ->
  count += 1
  $(this).find(".sort_handle").text(count)
