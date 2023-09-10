.ToothGrowth_fr <- function(ToothGrowth, labels_only = FALSE, as_labelled = FALSE) {

  comment(ToothGrowth) <- c(
    "Jeu de données 'ToothGrowth' de 'datasets'")

  ToothGrowth <- labelise(ToothGrowth, self = FALSE,
    label = list(
      len = "Allongement des dents",
      supp = "Supplément",
      dose = "Dose de vitamine C"),
    units = list(
      len = "mm",
      supp = NA,
      dose = "mg/d"),
    as_labelled = as_labelled)

  #if (!isTRUE(labels_only)) {
  # Nothing to do!
  # We could convert 'OJ' into 'JO' (jus d'orange) but does not change much
  #}

  ToothGrowth
}