.geyser_fr <- function(geyser, labels_only = FALSE, as_labelled = FALSE) {

  comment(geyser) <- c(
    "Jeu de données 'geyser' du package 'MASS', converti en 'dataframe'")

  geyser <- labelise(geyser, self = FALSE,
    label = list(
      waiting = "Temps d'attente",
      duration = "Durée d'éruption"),
    units = list(
      waiting = "min",
      duration = "min"),
    as_labelled = as_labelled)

  #if (!isTRUE(labels_only)) {
  # Nothing to do!
  #}

  geyser
}