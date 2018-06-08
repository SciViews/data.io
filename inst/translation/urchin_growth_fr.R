.urchin_growth_fr <- function(urchin_growth, labels.only = FALSE) {
  urchin_growth <- labelise(urchin_growth, self = FALSE,
    label = list(
      date = "Date",
      age = "Âge",
      diameter = "Diamètre du test"),
    units = list(
      date = NA,
      age = "années",
      diameter = "mm")
  )

  #if (!isTRUE(labels.only)) {
  #
  #}

  urchin_growth
}