.urchin_bio_fr <- function(urchin_bio, labels.only = FALSE) {
  urchin_bio <- labelise(urchin_bio, self = FALSE,
    label = list(
      origin = "Origine",
      diameter1 = "Diamètre du test #1",
      diameter2 = "Diamètre du test #2",
      height = "Hauteur du test",
      buoyant_weight = "Masse immergée",
      weight = "Masse totale",
      solid_parts = "Masse des parties solides",
      integuments = "Masse des téguments",
      dry_integuments = "Masse sèche des téguments",
      digestive_tract = "Masse du tube digestif",
      dry_digestive_tract = "Masse sèche du tube digestif",
      gonads = "Masse des gonades",
      dry_gonads = "Masse sèche des gonades",
      skeleton = "Masse du squelette",
      lantern = "Masse de la lanterne",
      test = "Masse du test",
      spines = "Masse des piquants",
      maturity = "Index de maturité gonadique",
      sex = "Sexe"),
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
      sex = NA)
  )

  if (!isTRUE(labels.only)) {
    levels(urchin_bio$origin) <- c("Culture", "Pêcherie")
    levels(urchin_bio$sex) <- c("F", "M")
  }

  urchin_bio
}
