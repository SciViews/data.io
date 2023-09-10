.births_fr <- function(births, labels_only = FALSE, as_labelled = FALSE) {

  comment(births) <- c(
    "Jeu de données 'births' du package 'babynames'")

  births <- labelise(births, self = FALSE,
    label = list(
      year = "Année",
      births = "Naissances"),
    units = list(
      year = NA,
      births = NA),
    as_labelled = as_labelled)

  #if (!isTRUE(labels_only)) {
  #  # Nothing to do
  #}

  births
}