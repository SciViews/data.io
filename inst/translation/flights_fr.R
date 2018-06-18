.flights_fr <- function(flights, labels_only = FALSE) {
  # flights de nycflights13
  # Les noms des variables ne sont pas modifiées. Quelques variables temporelles
  # sont encodées bizarrement (hhmm)
  # distance en miles (nautiques?) => km
  flights$distance <- round(flights$distance  * 1.852, 0)

  comment(flights) <- c(
  "Le jeu de données 'flights' de 'nycflights13' mais avec les distances en km",
    " Note dep_time, sched_dep_time, arr_time, sched_arr_time sont en 'hhmm'.")

  flights <- labelise(flights, self = FALSE,
    label = list(
      year = "Année",
      month = "Mois",
      day = "Jour",
      dep_time = "Heure de départ",
      sched_dep_time = "Heure prévue de départ",
      dep_delay = "Retard au départ",
      arr_time = "Heure d'arrivée",
      sched_arr_time = "Heure prévue d'arrivée",
      arr_delay = "Retard à l'arrivée",
      carrier = "Transporteur",
      flight = "Vol",
      tailnum = "Numéro de queue",
      origin = "Origine",
      dest = "Destination",
      air_time = "Temps de vol",
      distance = "Distance",
      hour = "Heure",
      minute = "Minute",
      time_hour = "Temps"),
    units = list(
      year = NA,
      month = NA,
      day = NA,
      dep_time = NA,
      sched_dep_time = NA,
      dep_delay = "min",
      arr_time = NA,
      sched_arr_time = NA,
      arr_delay = "min",
      carrier = NA,
      flight = NA,
      tailnum = NA,
      origin = NA,
      dest = NA,
      air_time = "min",
      distance = "km",
      hour = NA,
      minute = NA,
      time_hour = NA)
  )

  #if (!isTRUE(labels_only)) {
  # Nothing to do!
  #}

  flights
}
