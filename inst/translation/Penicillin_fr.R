.Penicillin_fr <- function(Penicillin, labels_only = FALSE, as_labelled = FALSE) {

  comment(Penicillin) <- c(
    "Jeu de données 'Penicillin' du package 'lme4'")

  Penicillin <- labelise(Penicillin, self = FALSE,
    label = list(
      diameter = "Diamètre de la zone d'inhibition",
      plate = "Boîte de Petri",
      sample = "Échantillon de pénicilline"),
    units = list(
      diameter = "mm",
      plate = NA,
      sample = NA),
    as_labelled = as_labelled)

  #if (!isTRUE(labels_only)) {
  # Nothing to do!
  #}

  Penicillin
}