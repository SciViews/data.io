.airports_fr <- function(airports, labels_only = FALSE, as_labelled = FALSE) {
  # airports comes from nycflights13

  airports$alt <- round(airports$alt / 3.2808, 0)
  airports$dst <- as.factor(airports$dst)
  levels(airports$dst) <- c("Standard US", "None", "Unknown")

  comment(airports) <- c(
    "Le jeu de données 'airports' de 'nycflights13' libellé et avec alt en m",
    " et dst en facteur avec des niveaux plus explicites")

  airports <- labelise(airports, self = FALSE,
    label = list(
      faa = "Code de l'aéroport",
      name = "Nom de l'aéroport",
      lat = "Latitude",
      lon = "Longitude",
      alt = "Altitude",
      tz = "Décalage horaire",
      dst = "Type de fuseau horaire",
      tzone = "Fuseau horaire IANA"),
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

  if (!isTRUE(labels_only)) {
    levels(airports$dst) <- c("US standard", "Aucun", "Inconnu")
  }

  airports
}
