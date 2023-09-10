.sleepstudy_en <- function(sleepstudy, labels_only = FALSE, as_labelled = FALSE) {

  names(sleepstudy) <- c("reaction", "days", "subject")
  comment(sleepstudy) <- c(
    "Dataset 'sleepstudy' from the package 'lme4' (column names in lowercase)")

  sleepstudy <- labelise(sleepstudy, self = FALSE,
    label = list(
      reaction = "Reaction time",
      days = "Sleep deprivation",
      subject = "Subject id"),
    units = list(
      reaction = "ms",
      days = "days",
      subject = NA),
    as_labelled = as_labelled)

  #if (!isTRUE(labels_only)) {
  # Nothing to do!
  #}

  sleepstudy
}