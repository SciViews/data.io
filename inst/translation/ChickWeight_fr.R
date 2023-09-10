.ChickWeight_fr <- function(ChickWeight, labels_only = FALSE, as_labelled = FALSE) {

  # The dataset has many attributes that we get rid of
  ChickWeight <- as.data.frame(ChickWeight)
  attr(ChickWeight, "formula") <- NULL
  attr(ChickWeight, "outer") <- NULL
  attr(ChickWeight, "labels") <- NULL
  attr(ChickWeight, "units") <- NULL
  names(ChickWeight) <- c("weight", "time", "chick", "diet")

  comment(ChickWeight) <- c(
    "Jeu de données 'ChickWeight' de 'datasets' (noms de colonnes en minuscules)")

  ChickWeight <- labelise(ChickWeight, self = FALSE,
    label = list(
      weight = "Masse",
      time = "Temps écoulé",
      chick = "Id poulet",
      diet = "Diète"),
    units = list(
      weight = "g",
      time = "jours",
      chick = NA,
      diet = NA),
    as_labelled = as_labelled)

  #if (!isTRUE(labels_only)) {
  # Nothing to do!
  #}

  ChickWeight
}