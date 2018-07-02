.crabs_en <- function(crabs, labels_only = FALSE, as_labelled = FALSE) {
  names(crabs) <- c("species", "sex", "index", "front", "rear", "length",
    "width", "depth")

  crabs <- labelise(crabs, self = FALSE,
    label = list(
      species = "Species",
      sex = "Sex",
      index = "Index",
      front = "Frontal lobe size",
      rear = "Rear width",
      length = "Carapace length",
      width = "Carapace width",
      depth = "Body depth"),
    units = list(
      species = NA,
      sex = NA,
      index = NA,
      front = "mm",
      rear = "mm",
      length = "mm",
      width = "mm",
      depth = "mm"),
    as_labelled = as_labelled)

  comment(trees) <- c(
    "The 'crabs' from 'MASS' but with variables renamed (sp -> Species,",
    "FL -> front, RW -> rear, CL -> length, CW -> width, BD -> depth)")

  #if (!isTRUE(labels_only)) {
    # Nothing to do here
  #}

  crabs
}

# TODO: EN_US -> size in inches.