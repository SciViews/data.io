.lifetables_fr <- function(lifetables, labels_only = FALSE, as_labelled = FALSE) {

  comment(lifetables) <- c(
    "Jeu de données 'lifetables' du package 'babynames'")

  lifetables <- labelise(lifetables, self = FALSE,
    label = list(
      x = "Âge",
      qx = "Probabilité de mortalité à x",
      lx = "Survivants/100000 à x+1",
      dx = "Mortalité à x+1",
      Lx = "Personne-années (x - x+1)",
      Tx = "Total personne-années (>x)",
      ex = "Espérance de vie à x",
      sex = "Genre",
      year = "Année"),
    units = list(
      x = "années",
      qx = NA,
      lx = NA,
      dx = NA,
      Lx = NA,
      Tx = NA,
      ex = "années",
      sex = NA,
      year = NA),
    as_labelled = as_labelled)

  if (!isTRUE(labels_only)) {
    sex_levels <- levels(lifetables$sex)
    sex_levels[sex_levels == "M"] <- "H"
    levels(lifetables$sex) <- sex_levels
  }

  lifetables
}