.ToothGrowth_en <- function(ToothGrowth, labels_only = FALSE, as_labelled = FALSE) {

  comment(ToothGrowth) <- c(
    "Dataset 'ToothGrowth' from the package 'datasets'")

  ToothGrowth <- labelise(ToothGrowth, self = FALSE,
    label = list(
      len = "Tooth growth",
      supp = "Supplement",
      dose = "Vitamin C dose"),
    units = list(
      len = "mm",
      supp = NA,
      dose = "mg/d"),
    as_labelled = as_labelled)

  #if (!isTRUE(labels_only)) {
  # Nothing to do!
  #}

  ToothGrowth
}