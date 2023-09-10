.sleepstudy_fr <- function(sleepstudy, labels_only = FALSE, as_labelled = FALSE) {

  names(sleepstudy) <- c("reaction", "days", "subject")
  comment(sleepstudy) <- c(
    "Jeu de données 'sleepstudy' du package 'lme4' (noms de colonnes en minuscules)")

  sleepstudy <- labelise(sleepstudy, self = FALSE,
    label = list(
      reaction = "Temps de réaction",
      days = "Privation de sommeil",
      subject = "Id sujet"),
    units = list(
      reaction = "ms",
      days = "jours",
      subject = NA),
    as_labelled = as_labelled)

  #if (!isTRUE(labels_only)) {
  # Nothing to do!
  #}

  sleepstudy
}