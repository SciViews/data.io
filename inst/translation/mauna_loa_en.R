.mauna_loa_en <- function(mauna_loa, labels_only = FALSE) {
  mauna_loa <- as_tsibble(mauna_loa, gather = FALSE)
  names(mauna_loa) <- c("time", "avg_temp", "min_temp", "max_temp", "avg_co2")

  mauna_loa <- labelise(mauna_loa, self = FALSE,
    label = list(
      time = "Time",
      avg_temp = "Monthly temperature",
      min_temp = "Minimal monthly temperature",
      max_temp = "Maximal monthly temperature",
      avg_co2 = "Monthly [atmospheric CO2]"),
    units = list(
      time = NA,
      avg_temp = "°C",
      min_temp = "°C",
      max_temp = "°C",
      avg_co2 = "ppm")
  )

  comment(mauna_loa) <- NULL

  #if (!isTRUE(labels_only)) {
  # Nothing to do!
  #}

  mauna_loa
}

.mauna_loa_en_us <- function(mauna_loa, labels_only = FALSE) {
  mauna_loa <- .mauna_loa_en(mauna_loa, labels_only = labels_only)
  # Temperature converted into °F
  mauna_loa$avg_temp <- round(mauna_loa$avg_temp * 1.8 + 32, 1)
  units(mauna_loa$avg_temp) <- "°F"
  mauna_loa$min_temp <- round(mauna_loa$min_temp * 1.8 + 32, 1)
  units(mauna_loa$min_temp) <- "°F"
  mauna_loa$max_temp <- round(mauna_loa$max_temp * 1.8 + 32, 1)
  units(mauna_loa$max_temp) <- "°F"

  comment(mauna_loa) <- "Temperatures in degrees Farenheit"

  #if (!isTRUE(labels_only)) {
  # Nothing to do!
  #}

  mauna_loa
}