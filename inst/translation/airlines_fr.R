.airlines_fr <- function(airlines, labels_only = FALSE, as_labelled = FALSE) {
  # airlines de nycflights13

  comment(airlines) <- c(
    "Le jeu de données 'airlines' de 'nycflights13' libellé.")

  airlines <- labelise(airlines, self = FALSE,
    label = list(
      carrier = "Transporteur",
      name = "Nom de la compagnie"),
    units = list(
      carrier = NA,
      name = NA),
    as_labelled = as_labelled)

  #if (!isTRUE(labels_only)) {
  # Nothing to do!
  #}

  airlines
}
