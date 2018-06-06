.urchin_bio_en <- function(urchin_bio, labels.only = FALSE) {
  urchin_bio$origin <- labelise(urchin_bio$origin, "Origin")
  urchin_bio$diameter1 <- labelise(urchin_bio$diameter1, "Test diameter #1", "mm")
  urchin_bio$diameter2 <- labelise(urchin_bio$diameter2, "Test diameter #2", "mm")
  urchin_bio$height <- labelise(urchin_bio$height, "Test height", "mm")
  urchin_bio$buoyant_weight <- labelise(urchin_bio$buoyant_weight, "Buoyant weight", "g")
  urchin_bio$weight <- labelise(urchin_bio$weight, "Total weight", "g")
  urchin_bio$solid_parts <- labelise(urchin_bio$solid_parts, "Weight of solid parts", "g")
  urchin_bio$integuments <- labelise(urchin_bio$integuments, "Weight of integuments", "g")
  urchin_bio$dry_integuments <- labelise(urchin_bio$dry_integuments, "Dry weight of integuments", "g")
  urchin_bio$digestive_tract <- labelise(urchin_bio$digestive_tract, "Weight of digestive tract", "g")
  urchin_bio$dry_digestive_tract <- labelise(urchin_bio$dry_digestive_tract, "Dry weight of digestive tract", "g")
  urchin_bio$gonads <- labelise(urchin_bio$gonads, "Weight of gonads", "g")
  urchin_bio$dry_gonads <- labelise(urchin_bio$dry_gonads, "Dry weight of gonads", "g")
  urchin_bio$skeleton <- labelise(urchin_bio$skeleton, "Weight of skeleton", "g")
  urchin_bio$lantern <- labelise(urchin_bio$lantern, "Weight of lantern", "g")
  urchin_bio$test <- labelise(urchin_bio$test, "Weight of test", "g")
  urchin_bio$spines <- labelise(urchin_bio$spines, "Weight of spines", "g")
  urchin_bio$maturity <- labelise(urchin_bio$maturity, "Gonads maturity index")
  urchin_bio$sex <- labelise(urchin_bio$sex, "Sex")

  if (!isTRUE(labels.only)) {
    levels(urchin_bio$origin) <- c("Farm", "Fishery")
    levels(urchin_bio$sex) <- c("F", "M")
  }

  urchin_bio
}

.urchin_bio_en_us <- .urchin_bio_en
