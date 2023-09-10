.penguins_en <- function(penguins, labels_only = FALSE, as_labelled = FALSE) {
  comment(penguins) <- "Units are taken out of variable names from original dataset."

  names(penguins) <- c("species", "island", "bill_length", "bill_depth",
    "flipper_length", "body_mass", "sex", "year")

  penguins <- labelise(penguins, self = FALSE,
    label = list(
      species = "Species",
      island = "Island",
      bill_length = "Bill length",
      bill_depth = "Bill depth",
      flipper_length = "Flipper length",
      body_mass = "Body mass",
      sex = "Sex",
      year = "Year"),
    units = list(
      species = NA,
      island = NA,
      bill_length = "mm",
      bill_depth = "mm",
      flipper_length = "mm",
      body_mass = "g",
      sex = NA,
      year = NA),
    as_labelled = as_labelled)

  #if (!isTRUE(labels_only)) {
  # Nothing to do!
  #}

  penguins
}

.penguins_en_us <- function(penguins, labels_only = FALSE) {
  penguins <- .penguins_en(penguins, labels_only = labels_only)

  penguins
}