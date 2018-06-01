.onLoad <- function(libname, pkgname) {
  .install_read_write_options()
}

# Internationalisation of datasets


# US English (default) ----------------------------------------------------
.urchin_bio_en <- function(urchin_bio, labels.only = FALSE) {
  urchin_bio$origin <- set_label(urchin_bio$origin, "Origin")
  urchin_bio$diameter1 <- set_label(urchin_bio$diameter1, "Test diameter #1", "mm")
  urchin_bio$diameter2 <- set_label(urchin_bio$diameter2, "Test diameter #2", "mm")
  urchin_bio$height <- set_label(urchin_bio$height, "Test height", "mm")
  urchin_bio$buoyant_weight <- set_label(urchin_bio$buoyant_weight, "Buoyant weight", "g")
  urchin_bio$weight <- set_label(urchin_bio$weight, "Total weight", "g")
  urchin_bio$solid_parts <- set_label(urchin_bio$solid_parts, "Weight of solid parts", "g")
  urchin_bio$integuments <- set_label(urchin_bio$integuments, "Weight of integuments", "g")
  urchin_bio$dry_integuments <- set_label(urchin_bio$dry_integuments, "Dry weight of integuments", "g")
  urchin_bio$digestive_tract <- set_label(urchin_bio$digestive_tract, "Weight of digestive tract", "g")
  urchin_bio$dry_digestive_tract <- set_label(urchin_bio$dry_digestive_tract, "Dry weight of digestive tract", "g")
  urchin_bio$gonads <- set_label(urchin_bio$gonads, "Weight of gonads", "g")
  urchin_bio$dry_gonads <- set_label(urchin_bio$dry_gonads, "Dry weight of gonads", "g")
  urchin_bio$skeleton <- set_label(urchin_bio$skeleton, "Weight of skeleton", "g")
  urchin_bio$lantern <- set_label(urchin_bio$lantern, "Weight of lantern", "g")
  urchin_bio$test <- set_label(urchin_bio$test, "Weight of test", "g")
  urchin_bio$spines <- set_label(urchin_bio$spines, "Weight of spines", "g")
  urchin_bio$maturity <- set_label(urchin_bio$maturity, "Gonads maturity index")
  urchin_bio$sex <- set_label(urchin_bio$sex, "Sex")

  if (!isTRUE(labels.only)) {
    levels(urchin_bio$origin) <- c("Farm", "Fishery")
    levels(urchin_bio$sex) <- c("F", "M")
  }

  urchin_bio
}

.urchin_bio_en_us <- .urchin_bio_en

# French ------------------------------------------------------------------
.urchin_bio_fr <- function(urchin_bio, labels.only = FALSE) {
  urchin_bio$origin <- set_label(urchin_bio$origin, "Origine")
  urchin_bio$diameter1 <- set_label(urchin_bio$diameter1, "Diamètre du test #1", "mm")
  urchin_bio$diameter2 <- set_label(urchin_bio$diameter2, "Diamètre du test #2", "mm")
  urchin_bio$height <- set_label(urchin_bio$height, "Hauteur du test", "mm")
  urchin_bio$buoyant_weight <- set_label(urchin_bio$buoyant_weight, "Masse immergée", "g")
  urchin_bio$weight <- set_label(urchin_bio$weight, "Masse totale", "g")
  urchin_bio$solid_parts <- set_label(urchin_bio$solid_parts, "Masse des parties solides", "g")
  urchin_bio$integuments <- set_label(urchin_bio$integuments, "Masse des téguments", "g")
  urchin_bio$dry_integuments <- set_label(urchin_bio$dry_integuments, "Masse sèche des téguments", "g")
  urchin_bio$digestive_tract <- set_label(urchin_bio$digestive_tract, "Masse du tube digestif", "g")
  urchin_bio$dry_digestive_tract <- set_label(urchin_bio$dry_digestive_tract, "Masse sèche du tube digestif", "g")
  urchin_bio$gonads <- set_label(urchin_bio$gonads, "Masse des gonades", "g")
  urchin_bio$dry_gonads <- set_label(urchin_bio$dry_gonads, "Masse sèche des gonades", "g")
  urchin_bio$skeleton <- set_label(urchin_bio$skeleton, "Masse du squelette", "g")
  urchin_bio$lantern <- set_label(urchin_bio$lantern, "Masse de la lanterne", "g")
  urchin_bio$test <- set_label(urchin_bio$test, "Masse du test", "g")
  urchin_bio$spines <- set_label(urchin_bio$spines, "Masse des piquants", "g")
  urchin_bio$maturity <- set_label(urchin_bio$maturity, "Index de maturité gonadique")
  urchin_bio$sex <- set_label(urchin_bio$sex, "Sexe")

  if (!isTRUE(labels.only)) {
    levels(urchin_bio$origin) <- c("Culture", "Pêcherie")
    levels(urchin_bio$sex) <- c("F", "M")
  }

  urchin_bio
}
