.applicants_en <- function(applicants, labels_only = FALSE, as_labelled = FALSE) {

  comment(applicants) <- c(
    "Dataset 'applicants' from package 'babynames'")

  applicants <- labelise(applicants, self = FALSE,
    label = list(
      year = "Year",
      sex = "Sex",
      n_all = "Number"),
    units = list(
      year = NA,
      sex = NA,
      n_all = NA),
    as_labelled = as_labelled)

  #if (!isTRUE(labels_only)) {
  #  # Nothing to do
  #}

  applicants
}