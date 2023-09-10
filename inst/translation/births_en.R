.births_en <- function(births, labels_only = FALSE, as_labelled = FALSE) {

  comment(births) <- c(
    "Dataset 'births' from package 'babynames'")

  births <- labelise(births, self = FALSE,
    label = list(
      year = "Year",
      births = "Births"),
    units = list(
      year = NA,
      births = NA),
    as_labelled = as_labelled)

  #if (!isTRUE(labels_only)) {
  #  # Nothing to do
  #}

  births
}