.penguins_raw_en <- function(penguins_raw, labels_only = FALSE, as_labelled = FALSE) {
  comment(penguins_raw) <- "Units are taken out of variable names from original dataset."

  names(penguins_raw) <- c("study", "sample", "species", "region", "island",
    "stage", "id", "clutch_done", "date_egg", "bill_length",
    "bill_depth", "flipper_length", "body_mass", "sex", "delta_15n",
    "delta_13c", "comment")

  penguins_raw <- labelise(penguins_raw, self = FALSE,
    label = list(
      study = "Study name",
      sample = "Sample number",
      species = "Species",
      region = "Region",
      island = "Island",
      stage = "Reproductive stage",
      id = "Individual id",
      clutch_done = "Clutch completion",
      date_egg = "Date of first egg",
      bill_length = "Bill length",
      bill_depth = "Bill depth",
      flipper_length = "Flipper length",
      body_mass = "Body mass",
      sex = "Sex",
      delta_15n = "Delta 15N:14N",
      delta_13c = "Delta 13C:12C",
      comment = "Comment"),
    units = list(
      study = NA,
      sample = NA,
      species = NA,
      region = NA,
      island = NA,
      stage = NA,
      id = NA,
      clutch_done = NA,
      date_egg = NA,
      bill_length = "mm",
      bill_depth = "mm",
      flipper_length = "mm",
      body_mass = "g",
      sex = NA,
      delta_15n = "‰",
      delta_13c = "‰",
      comment = NA),
    as_labelled = as_labelled)

  #if (!isTRUE(labels_only)) {
  # Nothing to do!
  #}

  penguins_raw
}

.penguins_raw_en_us <- function(penguins_raw, labels_only = FALSE) {
  penguins_raw <- .penguins_raw_en(penguins_raw, labels_only = labels_only)

  penguins_raw
}