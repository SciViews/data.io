.lifetables_en <- function(lifetables, labels_only = FALSE, as_labelled = FALSE) {

  comment(lifetables) <- c(
    "Data set 'lifetables' from package 'babynames'")

  lifetables <- labelise(lifetables, self = FALSE,
    label = list(
      x = "Age",
      qx = "Mortality probability at x",
      lx = "Survivors/100000 at x+1",
      dx = "Mortality at x+1",
      Lx = "Person-years (x - x+1)",
      Tx = "Total person-years (>x)",
      ex = "Life expectancy at x",
      sex = "Sex",
      year = "Year"),
    units = list(
      x = "years",
      qx = NA,
      lx = NA,
      dx = NA,
      Lx = NA,
      Tx = NA,
      ex = "years",
      sex = NA,
      year = NA),
    as_labelled = as_labelled)

  #if (!isTRUE(labels_only)) {
  #  # Nothing to do
  #}

  lifetables
}