.mpg_fr <- function(mpg, labels_only = FALSE) {
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
    "Jeu de données 'mpg' de 'ggplot2', avec quelques variables renommées",
    " (displ -> displacement, cyl -> cylinders, trans -> transmission,",
    " drv -> drive, cty -> mpg_city, hwy -> mpg_hwy, fl -> fuel).",
    " Plusieurs variables sont également transformées en facteurs.")

  mpg <- labelise(mpg, self = FALSE,
    label = list(
      manufacturer = "Constructeur",
      model = "Modèle",
      displacement = "Cylindrée",
      year = "Année",
      cylinders = "Nbr. de cyclindres",
      transmission = "Boite de vitesse",
      drive = "Motricité",
      cons_city = "Consommation (ville)",
      cons_hwy = "Consommation (autoroute)",
      fuel = "Carburant",
      class = "Type de voiture"),
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

  if (!isTRUE(labels_only)) {
    levels(mpg$transmission) <- c("auto(av)", "auto(l3)", "auto(l4)",
      "auto(l5)", "auto(l6)", "auto(s4)", "auto(s5)", "auto(s6)", "manu(m5)",
      "manu(m6)")
    levels(mpg$drive) <- c("4x4", "avant", "arrière")
    levels(mpg$fuel) <- c("lpg", "diesel", "ethanol", "essence98", "essence95")
    levels(mpg$class) <- c( "2places", "compacte", "moyenne", "monovolume",
      "pickup", "polyvalente", "suv")
    # Conversion de mpg (US) to L/100km
    mpg$cons_city <- round(1 / mpg$cons_city / 1.609344 * 378.5411784, 1)
    units(mpg$cons_city) <- "L/100km"
    mpg$cons_hwy <- round(1 / mpg$cons_hwy / 1.609344 * 378.5411784, 1)
    units(mpg$cons_hwy) <- "L/100km"
  }

  mpg
}
