.airports_en <- function(airports, labels_only = FALSE, as_labelled = FALSE) {
  # airports comes from nycflights13

  airports$alt <- round(airports$alt / 3.2808, 0)
  airports$dst <- as.factor(airports$dst)
  levels(airports$dst) <- c("Standard US", "None", "Unknown")

  comment(airports) <- c(
    "The 'airports' dataset from 'nycflights13' with labels, alt in m",
    " and dst as factor with explicit levels")

  airports <- labelise(airports, self = FALSE,
    label = list(
      faa = "Airport code",
      name = "Airport name",
      lat = "Latitude",
      lon = "Longitude",
      alt = "Altitude",
      tz = "Timezone offset",
      dst = "Daylight saving type",
      tzone = "IANA timezone"),
    units = list(
      faa = NA,
      name = NA,
      lat = NA,
      lon = NA,
      alt = "m",
      tz = "h",
      dst = NA,
      tzone = NA),
    as_labelled = as_labelled)

  #if (!isTRUE(labels_only)) {
    # Nothing to do
  #}

  airports
}

.airports_en_us <- function(airports, labels_only = FALSE,
as_labelled = FALSE) {
  airports$dst <- as.factor(airports$dst)
  levels(airports$dst) <- c("Standard US", "None", "Unknown")

  comment(airports) <- c(
    "The 'airports' dataset from 'nycflights13' with labels, alt in feet",
    " and dst as factor with explicit levels")

  airports <- labelise(airports, self = FALSE,
    label = list(
      faa = "Airport code",
      name = "Airport name",
      lat = "Latitude",
      lon = "Longitude",
      alt = "Altitude",
      tz = "Timezone offset",
      dst = "Daylight saving type",
      tzone = "IANA timezone"),
    units = list(
      faa = NA,
      name = NA,
      lat = NA,
      lon = NA,
      alt = "ft",
      tz = "h",
      dst = NA,
      tzone = NA),
    as_labelled = as_labelled)

  #if (!isTRUE(labels_only)) {
  # Nothing to do
  #}

  airports
}
