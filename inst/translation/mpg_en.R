.mpg_en <- function(mpg, labels_only = FALSE) {
  # Rename variables to stick to snake_case convention
  names(mpg) <- c("manufacturer", "model", "displacement", "year", "cylinders",
    "transmission", "drive", "cons_city", "cons_hwy", "fuel", "class")
  mpg$year <- as.ordered(mpg$year)
  mpg$cylinders <- as.ordered(mpg$cylinders)
  mpg$transmission <- as.factor(mpg$transmission)
  mpg$drive <- as.factor(mpg$drive)
  levels(mpg$drive) <- c("4wd", "front", "rear")
  mpg$fuel <- as.factor(mpg$fuel)
  levels(mpg$fuel) <- c("cng", "diesel", "ethanol", "premium", "regular")
  mpg$class <- as.factor(mpg$class)

  comment(mpg) <- c(
    "The 'mpg' from 'ggplot2', but with some variables renamed",
    " (displ -> displacement, cyl -> cylinders, trans -> transmission,",
    " drv -> drive, cty -> cons_city, hwy -> cons_hwy, fl -> fuel).",
    " Several variables are also transformed into factors.")

  mpg <- labelise(mpg, self = FALSE,
    label = list(
      manufacturer = "Manufacturer",
      model = "Model",
      displacement = "Displacement",
      year = "Year",
      cylinders = "Cylinders",
      transmission = "Transmission",
      drive = "Drive",
      cons_city = "Fuel consumption (city)",
      cons_hwy = "Fuel consumption (highway)",
      fuel = "Fuel type",
      class = "Car type"),
    units = list(
      manufacturer = NA,
      model = NA,
      displacement = "L",
      year = NA,
      cylinders = NA,
      transmission = NA,
      drive = NA,
      cons_city = "mpg",
      cons_hwy = "mpg",
      fuel = NA,
      class = NA)
  )

  #if (!isTRUE(labels_only)) {
  # Nothing to do!
  #}

  mpg
}
