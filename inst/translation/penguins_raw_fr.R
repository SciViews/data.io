.penguins_raw_fr <- function(penguins_raw, labels_only = FALSE, as_labelled = FALSE) {
  comment(penguins_raw) <- "Les unités sont retirées dans labels du jeu de données de départ."

  names(penguins_raw) <- c("study", "sample", "species", "region", "island",
    "stage", "id", "clutch_done", "date_egg", "bill_length",
    "bill_depth", "flipper_length", "body_mass", "sex", "delta_15n",
    "delta_13c", "comment")

  penguins_raw <- labelise(penguins_raw, self = FALSE,
    label = list(
      study = "Nom de l'étude",
      sample = "Numéro d'échantillon",
      species = "Espèce",
      region = "Région",
      island = "Île",
      stage = "Stade de reproduction",
      id = "Id individuel",
      clutch_done = "Ponte complète",
      date_egg = "Date du premier œuf",
      bill_length = "Longueur du bec",
      bill_depth = "Largeur du bec",
      flipper_length = "Longueur des nageoires",
      body_mass = "Masse corporelle",
      sex = "Sexe",
      delta_15n = "Delta 15N:14N",
      delta_13c = "Delta 13C:12C",
      comment = "Commentaire"),
    units = list(
      study = NA,
      sample = NA,
      species = NA,
      region = NA,
      island = NA,
      stage = NA,
      id = NA,
      clutch_done = NA,
      date_egg = NA,
      bill_length = "mm",
      bill_depth = "mm",
      flipper_length = "mm",
      body_mass = "g",
      sex = NA,
      delta_15n = "‰",
      delta_13c = "‰",
      comment = NA),
    as_labelled = as_labelled)

  #if (!isTRUE(labels_only)) {
  # Nothing to do!
  #}

  penguins_raw
}
