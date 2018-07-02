.urchin_growth_fr <- function(urchin_growth, labels_only = FALSE,
as_labelled = FALSE) {
  urchin_growth <- labelise(urchin_growth, self = FALSE,
    label = list(
      date = "Date",
      age = "Âge",
      diameter = "Diamètre du test"),
    units = list(
      date = NA,
      age = "années",
      diameter = "mm"),
    as_labelled = as_labelled)

  #if (!isTRUE(labels_only)) {
  #
  #}

  urchin_growth
}
