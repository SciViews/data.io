.airlines_fr <- function(airlines, labels_only = FALSE) {
  # airlines de nycflights13

  comment(airlines) <- c(
    "Le jeu de données 'airlines' de 'nycflights13' libellé.")

  airlines <- labelise(airlines, self = FALSE,
    label = list(
      carrier = "Transporteur",
      name = "Nom de la compagnie"),
    units = list(
      carrier = NA,
      name = NA)
  )

  #if (!isTRUE(labels_only)) {
  # Nothing to do!
  #}

  airlines
}
