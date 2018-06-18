.weather_en <- function(weather, labels_only = FALSE) {
  # weather comes from nycflights13
  # All units must be convertes into metric ones!
  # Fahrenheit into Celsius
  weather$temp <- round((weather$temp - 32) / 1.8, 1)
  weather$dewp <- round((weather$dewp - 32) / 1.8, 1)
  # mph is is nautical miles per hour? -> km/h
  weather$wind_speed <- round(weather$wind_speed * 1.852, 0)
  weather$wind_gust <- round(weather$wind_gust * 1.852, 0)
  # Inches into mm
  weather$precip <- round(weather$precip * 2.54 * 10, 0)
  # Miles (nautical?) into km
  weather$visib <- round(weather$visib * 1.852, 0)

  comment(weather) <- c(
    "The 'weather' dataset from 'nycflights13' with labels, all units",
    " converted into metrics (°F -> °C, miles -> km, mph -> km/h, in -> mm")

  weather <- labelise(weather, self = FALSE,
    label = list(
      origin = "Airport code",
      year = "Year",
      month = "Month",
      day = "Day",
      hour = "Hour",
      temp = "Temperature",
      dewp = "Dewpoint",
      humid = "Relative humidity",
      wind_dir = "Wind direction",
      wind_speed = "Wind speed",
      wind_gust = "Wind gust",
      precip = "Precipitation",
      pressure = "Pressure",
      visib = "Visibility",
      time_hour = "Time"),
    units = list(
      origin = NA,
      year = NA,
      month = NA,
      day = NA,
      hour = NA,
      temp = "°C",
      dewp = "°C",
      humid = "%",
      wind_dir = "°",
      wind_speed = "km/h",
      wind_gust = "km/h",
      precip = "mm",
      pressure = "mb",
      visib = "km",
      time_hour = NA)
  )

  #if (!isTRUE(labels_only)) {
  # Nothing to do
  #}

  weather
}

.weather_en_us <- function(weather, labels_only = FALSE) {
  # No conversion of the units!
  comment(weather) <- c(
    "The 'weather' dataset from 'nycflights13' with labels.")

  weather <- labelise(weather, self = FALSE,
    label = list(
      origin = "Airport code",
      year = "Year",
      month = "Month",
      day = "Day",
      hour = "Hour",
      temp = "Temperature",
      dewp = "Dewpoint",
      humid = "Relative humidity",
      wind_dir = "Wind direction",
      wind_speed = "Wind speed",
      wind_gust = "Wind gust",
      precip = "Precipitation",
      pressure = "Pressure",
      visib = "Visibility",
      time_hour = "Time"),
    units = list(
      origin = NA,
      year = NA,
      month = NA,
      day = NA,
      hour = NA,
      temp = "°F",
      dewp = "°F",
      humid = "%",
      wind_dir = "°",
      wind_speed = "mph",
      wind_gust = "mph",
      precip = "in",
      pressure = "mb",
      visib = "miles",
      time_hour = NA)
  )

  #if (!isTRUE(labels_only)) {
  # Nothing to do
  #}

  weather
}
