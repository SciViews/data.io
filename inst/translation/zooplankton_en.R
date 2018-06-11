.zooplankton_en <- function(zooplankton, labels_only = FALSE) {
  zooplankton <- labelise(zooplankton, self = FALSE,
    label = list(
      ecd = "Equivalent circular diameter",
      area = "Area",
      perimeter = "Perimeter",
      feret = "Feret diameter",
      major = "Ellipsoid major axis",
      minor = "Ellipsoid minor axis",
      mean = "Mean O.D.",
      mode = "Most frequent O.D.",
      min = "Minimal O.D.",
      max = "Maximal O.D.",
      std_dev = "O.D. standard deviation",
      range = "O.D. range",
      size = "Size",
      aspect = "Aspect ratio",
      elongation = "Elongation",
      compactness = "Compactness",
      transparency = "Transparency",
      circularity = "Circularity",
      density = "Integrated O.D.",
      class = "Class"),
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
      class = NA)
  )

  #if (!isTRUE(labels_only)) {
    # Nothing to do
  #}

  zooplankton
}
