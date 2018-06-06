.urchin_bio_fr <- function(urchin_bio, labels.only = FALSE) {
  urchin_bio$origin <- labelise(urchin_bio$origin, "Origine")
  urchin_bio$diameter1 <- labelise(urchin_bio$diameter1, "Diamètre du test #1", "mm")
  urchin_bio$diameter2 <- labelise(urchin_bio$diameter2, "Diamètre du test #2", "mm")
  urchin_bio$height <- labelise(urchin_bio$height, "Hauteur du test", "mm")
  urchin_bio$buoyant_weight <- labelise(urchin_bio$buoyant_weight, "Masse immergée", "g")
  urchin_bio$weight <- labelise(urchin_bio$weight, "Masse totale", "g")
  urchin_bio$solid_parts <- labelise(urchin_bio$solid_parts, "Masse des parties solides", "g")
  urchin_bio$integuments <- labelise(urchin_bio$integuments, "Masse des téguments", "g")
  urchin_bio$dry_integuments <- labelise(urchin_bio$dry_integuments, "Masse sèche des téguments", "g")
  urchin_bio$digestive_tract <- labelise(urchin_bio$digestive_tract, "Masse du tube digestif", "g")
  urchin_bio$dry_digestive_tract <- labelise(urchin_bio$dry_digestive_tract, "Masse sèche du tube digestif", "g")
  urchin_bio$gonads <- labelise(urchin_bio$gonads, "Masse des gonades", "g")
  urchin_bio$dry_gonads <- labelise(urchin_bio$dry_gonads, "Masse sèche des gonades", "g")
  urchin_bio$skeleton <- labelise(urchin_bio$skeleton, "Masse du squelette", "g")
  urchin_bio$lantern <- labelise(urchin_bio$lantern, "Masse de la lanterne", "g")
  urchin_bio$test <- labelise(urchin_bio$test, "Masse du test", "g")
  urchin_bio$spines <- labelise(urchin_bio$spines, "Masse des piquants", "g")
  urchin_bio$maturity <- labelise(urchin_bio$maturity, "Index de maturité gonadique")
  urchin_bio$sex <- labelise(urchin_bio$sex, "Sexe")

  if (!isTRUE(labels.only)) {
    levels(urchin_bio$origin) <- c("Culture", "Pêcherie")
    levels(urchin_bio$sex) <- c("F", "M")
  }

  urchin_bio
}
