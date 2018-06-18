.airlines_en <- function(airlines, labels_only = FALSE) {
  # airlines comes from nycflights13

  comment(airlines) <- c(
    "The 'airlines' from 'nycflights13' with labels.")

  airlines <- labelise(airlines, self = FALSE,
    label = list(
      carrier = "Carrier id",
      name = "Carrier name"),
    units = list(
      carrier = NA,
      name = NA)
  )

  #if (!isTRUE(labels_only)) {
  # Nothing to do!
  #}

  airlines
}
