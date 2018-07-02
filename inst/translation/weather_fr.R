.weather_fr <- function(weather, labels_only = FALSE, as_labelled = FALSE) {
  # weather de nycflights13
  # Conversion de toutes les unités en valeurs métriques!
  # Fahrenheit en Celsius
  weather$temp <- round((weather$temp - 32) / 1.8, 1)
  weather$dewp <- round((weather$dewp - 32) / 1.8, 1)
  # mph, miles (nautiques?) par h en km/h?
  weather$wind_speed <- round(weather$wind_speed * 1.852, 0)
  weather$wind_gust <- round(weather$wind_gust * 1.852, 0)
  # Pouces en mm
  weather$precip <- round(weather$precip * 2.54 * 10, 0)
  # Miles (nautiques?) en km
  weather$visib <- round(weather$visib * 1.852, 0)

  comment(weather) <- c(
    "Le jeu de données 'weather' de 'nycflights13' libellé, toutes les unités",
    " converties en métriques (°F -> °C, miles -> km, mph -> km/h, in -> cm")

  weather <- labelise(weather, self = FALSE,
    label = list(
      origin = "Code d'aéroport",
      year = "Année",
      month = "Mois",
      day = "Jour",
      hour = "Heure",
      temp = "Température",
      dewp = "Point de rosée",
      humid = "Humidité relative",
      wind_dir = "Direction du vent",
      wind_speed = "Vitesse du vent",
      wind_gust = "Rafales de vent",
      precip = "Précipitations",
      pressure = "Pression atmosphérique",
      visib = "Visibilité",
      time_hour = "Temps"),
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
      time_hour = NA),
    as_labelled = as_labelled)

  #if (!isTRUE(labels_only)) {
  # Nothing to do
  #}

  weather
}
