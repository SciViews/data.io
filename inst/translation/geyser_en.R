.geyser_en <- function(geyser, labels_only = FALSE, as_labelled = FALSE) {

  comment(geyser) <- c(
    "The 'geyser' dataset from 'MASS'")

  geyser <- labelise(geyser, self = FALSE,
    label = list(
      waiting = "Waiting time",
      duration = "Eruption time"),
    units = list(
      waiting = "min",
      duration = "min"),
    as_labelled = as_labelled)

  #if (!isTRUE(labels_only)) {
  # Nothing to do!
  #}

  geyser
}