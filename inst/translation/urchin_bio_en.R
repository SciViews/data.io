.urchin_bio_en <- function(urchin_bio, labels_only = FALSE,
as_labelled = FALSE) {
  urchin_bio <- labelise(urchin_bio, self = FALSE,
    label = list(
      origin = "Origin",
      diameter1 = "Test diameter #1",
      diameter2 = "Test diameter #2",
      height = "Test height",
      buoyant_weight = "Buoyant weight",
      weight = "Total weight",
      solid_parts = "Weight of solid parts",
      integuments = "Weight of integuments",
      dry_integuments = "Dry weight of integuments",
      digestive_tract = "Weight of digestive tract",
      dry_digestive_tract = "Dry weight of digestive tract",
      gonads = "Weight of gonads",
      dry_gonads = "Dry weight of gonads",
      skeleton = "Weight of skeleton",
      lantern = "Weight of lantern",
      test = "Weight of test",
      spines = "Weight of spines",
      maturity = "Gonads maturity index",
      sex = "Sex"),
    units = list(
      origin = NA,
      diameter1 = "mm",
      diameter2 = "mm",
      height = "mm",
      buoyant_weight = "g",
      weight = "g",
      solid_parts = "g",
      integuments = "g",
      dry_integuments = "g",
      digestive_tract = "g",
      dry_digestive_tract = "g",
      gonads = "g",
      dry_gonads = "g",
      skeleton = "g",
      lantern = "g",
      test = "g",
      spines = "g",
      maturity = NA,
      sex = NA),
    as_labelled = as_labelled)

  if (!isTRUE(labels_only)) {
    levels(urchin_bio$origin) <- c("Farm", "Fishery")
    levels(urchin_bio$sex) <- c("F", "M")
  }

  urchin_bio
}

.urchin_bio_en_us <- .urchin_bio_en # TODO: imperial units, labels_only = FALSE
