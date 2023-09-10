.zooplankton_fr <- function(zooplankton, labels_only = FALSE,
as_labelled = FALSE) {
  zooplankton <- labelise(zooplankton, self = FALSE,
    label = list(
      ecd = "Diamètre circulaire équivalent",
      area = "Aire",
      perimeter = "Périmètre",
      feret = "Diamètre de Feret",
      major = "Axe majeur de l'ellipsoïde",
      minor = "Axe mineur de l'ellipsoïde",
      mean = "D.O. moyenne",
      mode = "D.O. plus fréquente",
      min = "D.O. minimale",
      max = "D.O. maximale",
      std_dev = "D.O. écart type",
      range = "Etendue des D.O.",
      size = "Taille",
      aspect = "Ratio d'aspect",
      elongation = "Elongation",
      compactness = "Compacité",
      transparency = "Transparence",
      circularity = "Circularité",
      density = "D.O. intégrée",
      class = "Classe"),
    units = list(
      ecd = "mm",
      area = "mm^2",
      perimeter = "mm",
      feret = "mm",
      major = "mm",
      minor = "mm",
      mean = NA,
      mode = NA,
      min = NA,
      max = NA,
      std_dev = NA,
      range = NA,
      size = "mm",
      aspect = NA,
      elongation = NA,
      compactness = NA,
      transparency = NA,
      circularity = NA,
      density = NA,
      class = NA),
    as_labelled = as_labelled)

  if (!isTRUE(labels_only)) {
    levels(zooplankton$class) <- c("Annélide", "Appendiculaire", "Calanoïde",
      "Chaetognathe", "Cirripède", "Cladocère", "Cnidaire", "Cyclopoïde",
      "Décapode", "Oeuf_allongé", "Oeuf_rond", "Poisson", "Gastéropode",
      "Harpacticoïde", "Malacostracé", "Poecilostomatoïde", "Protiste")
  }

  zooplankton
}
