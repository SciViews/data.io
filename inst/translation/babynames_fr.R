.babynames_fr <- function(babynames, labels_only = FALSE, as_labelled = FALSE) {

  comment(babynames) <- c(
    "Jeu de données 'babynames' du package 'babynames'")

  babynames <- labelise(babynames, self = FALSE,
    label = list(
      year = "Année",
      sex = "Genre",
      name = "Nom",
      n = "Nombre",
      prop = "Proportion"),
    units = list(
      year = NA,
      sex = NA,
      name = NA,
      n = NA,
      prop = NA),
    as_labelled = as_labelled)

  if (!isTRUE(labels_only)) {
    babynames$sex[babynames$sex == "M"] <- "H" # Or "F"
  }

  babynames
}