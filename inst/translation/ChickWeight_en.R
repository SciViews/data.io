.ChickWeight_en <- function(ChickWeight, labels_only = FALSE, as_labelled = FALSE) {

  # The dataset has many attributes that we get rid of
  ChickWeight <- as.data.frame(ChickWeight)
  attr(ChickWeight, "formula") <- NULL
  attr(ChickWeight, "outer") <- NULL
  attr(ChickWeight, "labels") <- NULL
  attr(ChickWeight, "units") <- NULL
  names(ChickWeight) <- c("weight", "time", "chick", "diet")

  comment(ChickWeight) <- c(
    "The 'ChickWeight' dataset from 'datasets' (all columns names in lowercase)")

  ChickWeight <- labelise(ChickWeight, self = FALSE,
    label = list(
      weight = "Body mass",
      time = "Elapsed time",
      chick = "Chick id",
      diet = "Diet"),
    units = list(
      weight = "g",
      time = "days",
      chick = NA,
      diet = NA),
    as_labelled = as_labelled)

  #if (!isTRUE(labels_only)) {
  # Nothing to do!
  #}

  ChickWeight
}