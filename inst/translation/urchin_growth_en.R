.urchin_growth_en <- function(urchin_growth, labels_only = FALSE) {
  urchin_growth <- labelise(urchin_growth, self = FALSE,
    label = list(
      date = "Date",
      age = "Age",
      diameter = "Test diameter"),
    units = list(
      date = NA,
      age = "years",
      diameter = "mm")
  )

  #if (!isTRUE(labels_only)) {
  #
  #}

  urchin_growth
}