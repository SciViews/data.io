.urchin_growth_fr <- function(urchin_growth, labels.only = FALSE) {
  urchin_growth$date <- labelise(urchin_growth$date, "Date")
  urchin_growth$age <- labelise(urchin_growth$age, "Âge", "années")
  urchin_growth$diameter <- labelise(urchin_growth$diameter, "Diamètre du test", "mm")

  #if (!isTRUE(labels.only)) {
  #
  #}

  urchin_growth
}