.faithful_fr <- function(faithful, labels_only = FALSE, as_labelled = FALSE) {

  comment(faithful) <- c(
    "Jeu de données 'faithful' du package 'datasets'")

  faithful <- labelise(faithful, self = FALSE,
    label = list(
      eruptions = "Durée d'éruption",
      waiting = "Temps d'attente"),
    units = list(
      eruptions = "min",
      waiting = "min"),
    as_labelled = as_labelled)

  #if (!isTRUE(labels_only)) {
  # Nothing to do!
  #}

  faithful
}