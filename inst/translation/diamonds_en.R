.diamonds_en <- function(diamonds, labels_only = FALSE, as_labelled = FALSE) {
  comment(diamonds) <- NULL

  diamonds <- labelise(diamonds, self = FALSE,
    label = list(
      carat = "Weight",
      cut = "Cut quality",
      color = "Colour",
      clarity = "Clarity",
      depth = "Depth",
      table = "Table",
      price = "Price",
      x = "Length",
      y = "Width",
      z = "Height"),
    units = list(
      carat = "ct",
      cut = NA,
      color = NA,
      clarity = NA,
      depth = "%",
      table = "%",
      price = "US$",
      x = "mm",
      y = "mm",
      z = "mm"),
    as_labelled = as_labelled)

  #if (!isTRUE(labels_only)) {
  # Nothing to do!
  #}

  diamonds
}

.diamonds_en_us <- function(diamonds, labels_only = FALSE) {
  diamonds <- .diamonds_en(diamonds, labels_only = labels_only)

  label(diamonds$color) <- "Color"

  diamonds
}