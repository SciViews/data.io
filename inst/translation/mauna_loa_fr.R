.mauna_loa_fr <- function(mauna_loa, labels_only = FALSE, as_labelled = FALSE) {
  mauna_loa <- as_tsibble(mauna_loa, pivot_longer = FALSE)
  names(mauna_loa) <- c("time", "avg_temp", "min_temp", "max_temp", "avg_co2")

  mauna_loa <- labelise(mauna_loa, self = FALSE,
    label = list(
      time = "Temps",
      avg_temp = "Températures mensuelles moyennes",
      min_temp = "Températures mensuelles minimales",
      max_temp = "Températures mensuelles maximales",
      avg_co2 = "[CO2 atmosphérique]"),
    units = list(
      time = NA,
      avg_temp = "°C",
      min_temp = "°C",
      max_temp = "°C",
      avg_co2 = "ppm"),
    as_labelled = as_labelled)

  comment(mauna_loa) <- NULL

  #if (!isTRUE(labels_only)) {
  # Nothing to do!
  #}

  mauna_loa
}
