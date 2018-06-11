.co2_en <- function(co2, labels_only = FALSE) {
  co2 <- as_tsibble(co2)
  names(co2) <- c("time", "co2" )

  comment(co2) <- c(
    "The 'co2' from 'datasets', translated into a 'dataframe'")

  co2 <- labelise(co2, self = FALSE,
    label = list(
      time = "Time",
      co2 = "[CO2 atm]"),
    units = list(
      time = NA,
      co2 = "ppmv")
  )

  #if (!isTRUE(labels_only)) {
  # Nothing to do!
  #}

  co2
}