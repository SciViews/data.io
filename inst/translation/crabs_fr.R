.crabs_en <- function(crabs, labels_only = FALSE, as_labelled = FALSE) {
  names(crabs) <- c("species", "sex", "index", "front", "rear", "length",
    "width", "depth")

  crabs <- labelise(crabs, self = FALSE,
    label = list(
      species = "Espèce",
      sex = "Sexe",
      index = "Indice",
      front = "Taille du lobe frontal",
      rear = "Largeur à l'arrière",
      length = "Longueur de carapace",
      width = "Largeur de carapace",
      depth = "Épaisseur du corps"),
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
    "Jeu de données 'crabs' de 'MASS' avec variables renommées (sp -> Species,",
    "FL -> front, RW -> rear, CL -> length, CW -> width, BD -> depth)")

  #if (!isTRUE(labels_only)) {
    # Nothing to do here
  #}

  crabs
}

