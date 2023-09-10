.Penicillin_en <- function(Penicillin, labels_only = FALSE, as_labelled = FALSE) {

  comment(Penicillin) <- c(
    "Data set 'Penicillin' from package 'lme4'")

  Penicillin <- labelise(Penicillin, self = FALSE,
    label = list(
      diameter = "Inhibition zone diameter",
      plate = "Assay plate",
      sample = "Penicillin sample"),
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