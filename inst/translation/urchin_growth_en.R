.urchin_growth_en <- function(urchin_growth, labels.only = FALSE) {
  urchin_growth$date <- labelise(urchin_growth$date, "Date")
  urchin_growth$age <- labelise(urchin_growth$age, "Age", "years")
  urchin_growth$diameter <- labelise(urchin_growth$diameter, "Test diameter", "mm")

  #if (!isTRUE(labels.only)) {
  #
  #}

  urchin_growth
}