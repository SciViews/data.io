.iris_en <- function(iris, labels_only = FALSE) {
  # Rename variables to stick to snake_case convention
  names(iris) <-
    c("sepal_length", "sepal_width", "petal_length", "petal_width", "species" )
  iris$species <- as.factor(iris$species)

  comment(iris) <- c(
"The 'iris' from 'datasets', but with variables names in snake_case",
"(Sepal.Length -> sepal_length, Species -> species).")

  iris <- labelise(iris, self = FALSE,
    label = list(
      sepal_length = "Length of the sepals",
      sepal_width = "Width of the sepals",
      petal_length = "Length of the petals",
      petal_width = "Width of the petals",
      species = "Iris species"),
    units = list(
      sepal_length = "cm",
      sepal_width = "cm",
      petal_length = "cm",
      petal_width = "cm",
      species = NA)
  )

  #if (!isTRUE(labels_only)) {
    # Nothing to do!
  #}

  iris
}

# TODO: en_US en inches.