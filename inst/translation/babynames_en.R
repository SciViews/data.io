.babynames_en <- function(babynames, labels_only = FALSE, as_labelled = FALSE) {

  comment(babynames) <- c(
    "Data set 'babynames' from package 'babynames'")

  babynames <- labelise(babynames, self = FALSE,
    label = list(
      year = "Year",
      sex = "Sex",
      name = "Name",
      n = "Number",
      prop = "Proportion"),
    units = list(
      year = NA,
      sex = NA,
      name = NA,
      n = NA,
      prop = NA),
    as_labelled = as_labelled)

  #if (!isTRUE(labels_only)) {
  # Nothing to do!
  #}

  babynames
}