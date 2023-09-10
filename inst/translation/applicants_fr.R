.applicants_fr <- function(applicants, labels_only = FALSE, as_labelled = FALSE) {

  comment(applicants) <- c(
    "Jeu de données 'applicants' du package 'babynames'")

  applicants <- labelise(applicants, self = FALSE,
    label = list(
      year = "Année",
      sex = "Genre",
      n_all = "Nombre"),
    units = list(
      year = NA,
      sex = NA,
      n_all = NA),
    as_labelled = as_labelled)

  if (!isTRUE(labels_only)) {
    applicants$sex[applicants$sex == "M"] <- "H" # Or "F"
  }

  applicants
}