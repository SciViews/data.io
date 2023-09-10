.penguins_fr <- function(penguins, labels_only = FALSE, as_labelled = FALSE) {
  comment(penguins) <- "Les unités sont retirées dans labels du jeu de données de départ."

  names(penguins) <- c("species", "island", "bill_length", "bill_depth",
    "flipper_length", "body_mass", "sex", "year")

  penguins <- labelise(penguins, self = FALSE,
    label = list(
      species = "Espèce",
      island = "Île",
      bill_length = "Longueur du bec",
      bill_depth = "Largeur du bec",
      flipper_length = "Longueur des nageoires",
      body_mass = "Masse corporelle",
      sex = "Sexe",
      year = "Année"),
    units = list(
      species = NA,
      island = NA,
      bill_length = "mm",
      bill_depth = "mm",
      flipper_length = "mm",
      body_mass = "g",
      sex = NA,
      year = NA),
    as_labelled = as_labelled)

  #if (!isTRUE(labels_only)) {
  # Nothing to do!
  #}

  penguins
}
