.planes_fr <- function(planes, labels_only = FALSE) {
  # planes de nycflights13

  # vitesse en miles (nautiques?) par heure => conversion en km/h
  planes$speed <- planes$speed * 1.852

  planes$type <- as.factor(planes$type)
  planes$engine <- as.factor(planes$engine)

  comment(planes) <- c(
    "Le jeu de données 'planes' de 'nycflights13' libellé. type et engine",
    " sont convertis en facteurs, speed est convertie en km/h")

  planes <- labelise(planes, self = FALSE,
    label = list(
      tailnum = "Numéro de queue",
      year = "Année de construction",
      type = "Type d'avion",
      manufacturer = "Constructeur",
      model = "Modèle",
      engines = "Nbr de moteurs",
      seats = "Nbr de sièges",
      speed = "Vitesse",
      engine = "Type de moteur"),
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

  if (!isTRUE(labels_only)) {
   # Les niveaux de type et engines sont traduits
    levels(planes$type) <- c("Ailes fixes moteurs multiples",
      "Ailes fixes moteur unique", "Appareil à rotor")
    levels(planes$engine) <- c("4 Cycles", "Moteur à pistons",
      "Turboréacteur double flux", "Turboréacteur simple", "Turbopropulseur",
      "Turbomoteur")
  }

  planes
}
