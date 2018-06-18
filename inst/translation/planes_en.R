.planes_en <- function(planes, labels_only = FALSE) {
  # planes comes from nycflights13

  # speed is in (nautical?) miles per hour => convert into km/h
  planes$speed <- planes$speed * 1.852

  planes$type <- as.factor(planes$type)
  planes$engine <- as.factor(planes$engine)

  comment(planes) <- c(
    "The 'planes' dataset from 'nycflights13' with labels. type and engine",
    " are converted as factors, seepd is converted into km/h")

  planes <- labelise(planes, self = FALSE,
    label = list(
      tailnum = "Tail number",
      year = "Year manufactured",
      type = "Type of plane",
      manufacturer = "Manufacturer",
      model = "Model",
      engines = "Nbr of engines",
      seats = "Nbr of seats",
      speed = "Speed",
      engine = "Type of engine"),
    units = list(
      tailnum = NA,
      year = NA,
      type = NA,
      manufacturer = NA,
      model = NA,
      engines = NA,
      seats = NA,
      speed = "km/h",
      engine = NA)
  )

  #if (!isTRUE(labels_only)) {
  # Nothing to do
  #}

  planes
}

.planes_en_us <- function(planes, labels_only = FALSE) {
  # planes comes from nycflights13

  planes$type <- as.factor(planes$type)
  planes$engine <- as.factor(planes$engine)

  comment(planes) <- c(
    "The 'planes' dataset from 'nycflights13' with labels. type and engine",
    " are converted as factors")

  planes <- labelise(planes, self = FALSE,
    label = list(
      tailnum = "Tail number",
      year = "Year manufactured",
      type = "Type of plane",
      manufacturer = "Manufacturer",
      model = "Model",
      engines = "Nbr of engines",
      seats = "Nbr of seats",
      speed = "Speed",
      engine = "Type of engine"),
    units = list(
      tailnum = NA,
      year = NA,
      type = NA,
      manufacturer = NA,
      model = NA,
      engines = NA,
      seats = NA,
      speed = "mph",
      engine = NA)
  )

  #if (!isTRUE(labels_only)) {
  # Nothing to do
  #}

  planes
}
