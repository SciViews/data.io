.iris_fr <- function(iris, labels_only = FALSE, as_labelled = FALSE) {
  # Rename variables to stick to snake_case convention
  names(iris) <-
    c("sepal_length", "sepal_width", "petal_length", "petal_width", "species" )
  iris$species <- as.factor(iris$species)

  comment(iris) <-  c(
"Jeu de données 'iris' de 'datasets', mais avec noms de variables modifiées",
"(Sepal.Length -> sepal_length, Species -> species).")

  iris <- labelise(iris, self = FALSE,
    label = list(
      sepal_length = "Longueur des sépales",
      sepal_width = "Largeur des sépales",
      petal_length = "Longueur des pétales",
      petal_width = "Largeur des pétales",
      species = "Espèces d'Iris"),
    units = list(
      sepal_length = "cm",
      sepal_width = "cm",
      petal_length = "cm",
      petal_width = "cm",
      species = NA),
    as_labelled = as_labelled)

  #if (!isTRUE(labels_only)) {
    # Nothing to do!
  #}

  iris
}