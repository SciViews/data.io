.trees_en <- function(trees, labels_only = FALSE) {
  # The trees dataset has a couple of glitches:
  # 1) Girth is indeed the Diameter (and variables not in snake_case), so rename
  names(trees) <- c("diameter", "height", "volume")

  # 2) Data are in imperial units (in, ft, and cubic ft) => transform into
  #    m, m, and m^3
  trees$diameter <- round(trees$diameter * 2.54 / 100, 3)
  trees$height <- round(trees$height * 0.3048, 1)
  trees$volume <- round(trees$volume / 35.315, 3)

  comment(trees) <- c(
"Jeu de données 'trees' de 'datasets' avec variables renommées et en m ou m^3",
"(Girth [in] -> diameter [m], Height [ft] -> height [m],",
"Volume [ft^3] -> volume [m^3]).")

  trees <- labelise(trees, self = FALSE,
    label = list(
      diameter = "Diamètre à 1,4m",
      height = "Hauteur",
      volume = "Volume de bois"),
    units = list(
      diameter = "m",
      height = "m",
      volume = "m^3")
  )

  #if (!isTRUE(labels_only)) {
  # Nothing to do!
  #}

  trees
}