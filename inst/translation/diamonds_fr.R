.diamonds_fr <- function(diamonds, labels_only = FALSE, as_labelled = FALSE) {
  comment(diamonds) <- NULL

  diamonds <- labelise(diamonds, self = FALSE,
    label = list(
      carat = "Poids",
      cut = "Taille",
      color = "Couleur",
      clarity = "Pureté",
      depth = "Profondeur",
      table = "Table",
      price = "Prix",
      x = "Longueur",
      y = "Largeur",
      z = "Hauteur"),
    units = list(
      carat = "ct",
      cut = NA,
      color = NA,
      clarity = NA,
      depth = "%",
      table = "%",
      price = "$US",
      x = "mm",
      y = "mm",
      z = "mm"),
    as_labelled = as_labelled)

  if (!isTRUE(labels_only)) {
    levels(diamonds$cut) <-
      c("Acceptable", "Bonne", "Très bonne", "Prémium", "Idéale")
  }

  diamonds
}
