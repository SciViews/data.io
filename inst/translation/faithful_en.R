.faithful_en <- function(faithful, labels_only = FALSE, as_labelled = FALSE) {

  comment(faithful) <- c(
    "The 'faithful' dataset from 'datasets'")

  faithful <- labelise(faithful, self = FALSE,
    label = list(
      eruptions = "Eruption time",
      waiting = "Waiting time"),
    units = list(
      eruptions = "min",
      waiting = "min"),
    as_labelled = as_labelled)

  #if (!isTRUE(labels_only)) {
  # Nothing to do!
  #}

  faithful
}