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
"The 'trees' from 'datasets' but with variables renamed and in m or m^3",
"(Girth [in] -> diameter [m], Height [ft] -> height [m],",
"Volume [ft^3] -> volume [m^3]).")

  trees <- labelise(trees, self = FALSE,
    label = list(
      diameter = "Diameter at 1.4m",
      height = "Height",
      volume = "Volume of timber"),
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

.trees_en_us <- function(trees, labels_only = FALSE) {
  # The trees dataset has a couple of glitches:
  # 1) Girth is indeed the Diameter (and variables not in snake_case), so rename
  names(trees) <- c("diameter", "height", "volume")

  # 2) Data are in imperial units (in, ft, and cubic ft) => transform into
  #    m, m, and m^3 for labels_only = TRUE
  if (isTRUE(labels_only)) {
    trees$diameter <- round(trees$diameter * 2.54 / 100, 3)
    trees$height <- round(trees$height * 0.3048, 1)
    trees$volume <- round(trees$volume / 35.315, 3)
    lab_diam <- "Diameter at 1.4m"
    var_units <- c("m", "m", "m^3")
    comment(trees) <- c(
      "The 'trees' from 'datasets' but with variables renamed and in m or m^3",
      "(Girth [in] -> diameter [m], Height [ft] -> height [m],",
      "Volume [ft^3] -> volume [m^3]).")
  } else {# Keep original imperial units
    lab_diam <- "Diameter at 4ft 6in"
    var_units <- c("in", "ft", "ft^3")
    comment(trees) <- c("The 'trees' from 'datasets' with variables renamed.")
  }

  trees <- labelise(trees, self = FALSE,
    label = list(
      diameter = lab_diam,
      height = "Height",
      volume = "Volume of timber"),
    units = list(
      diameter = var_units[1],
      height = var_units[2],
      volume = var_units[3])
  )

  trees
}