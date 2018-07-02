.flights_en <- function(flights, labels_only = FALSE, as_labelled = FALSE) {
  # flights comes from nycflights13
  # We don't change the names of the variables, but some time variables are
  # really strangely encoded (hhmm)
  # distance in (nautical?) miles => km
  flights$distance <- round(flights$distance  * 1.852, 0)

  comment(flights) <- c(
    "The 'flights' from 'nycflights13' but with distance in km",
    " Note dep_time, sched_dep_time, arr_time, sched_arr_time are in 'hhmm'.")

  flights <- labelise(flights, self = FALSE,
    label = list(
      year = "Year",
      month = "Month",
      day = "Day",
      dep_time = "Departure time",
      sched_dep_time = "Scheduled departure time",
      dep_delay = "Departure delay",
      arr_time = "Arrival time",
      sched_arr_time = "Scheduled arrival time",
      arr_delay = "Arrival delay",
      carrier = "Carrier",
      flight = "Flight",
      tailnum = "Tail number",
      origin = "Origin",
      dest = "Destination",
      air_time = "Air time",
      distance = "Distance",
      hour = "Hour",
      minute = "Minute",
      time_hour = "Time"),
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
      time_hour = NA),
    as_labelled = as_labelled)

  #if (!isTRUE(labels_only)) {
  # Nothing to do!
  #}

  flights
}

.flights_en_us <- function(flights, labels_only = FALSE, as_labelled = FALSE) {
  # flights comes from nycflights13
  # We don't change the names of the variables, but some time variables are
  # really strangely encoded (hhmm)

  comment(flights) <- c(
    "The 'flights' from 'nycflights13'. Note thatdep_time, sched_dep_time,",
    " arr_time, sched_arr_time are in 'hhmm'.")

  flights <- labelise(flights, self = FALSE,
    label = list(
      year = "Year",
      month = "Month",
      day = "Day",
      dep_time = "Departure time",
      sched_dep_time = "Scheduled departure time",
      dep_delay = "Departure delay",
      arr_time = "Arrival time",
      sched_arr_time = "Scheduled arrival time",
      arr_delay = "Arrival delay",
      carrier = "Carrier",
      flight = "Flight",
      tailnum = "Tail number",
      origin = "Origin",
      dest = "Destination",
      air_time = "Air time",
      distance = "Distance",
      hour = "Hour",
      minute = "Minute",
      time_hour = "Time"),
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
      distance = "miles",
      hour = NA,
      minute = NA,
      time_hour = NA),
    as_labelled = as_labelled)

  #if (!isTRUE(labels_only)) {
  # Nothing to do!
  #}

  flights
}