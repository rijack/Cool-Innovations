if ("<%= @changedField%>" == "status")
  sep = "?"
  if document.location.toString().indexOf('?') != -1
    sep = "&"
  document.location = document.location + sep + "shipped=true"
