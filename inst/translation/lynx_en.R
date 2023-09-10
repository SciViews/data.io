.lynx_en <- function(lynx, labels_only = FALSE, as_labelled = FALSE) {
  lynx <- as_tsibble(lynx)
  names(lynx) <- c("time", "trapping" )

  comment(lynx) <- c(
    "The 'lynx' from 'datasets', translated into a 'dataframe'")

  lynx <- labelise(lynx, self = FALSE,
    label = list(
      time = "Time",
      trapping = "Lynx trapped"),
    units = list(
      time = "years",
      trapping = NA),
    as_labelled = as_labelled)

  #if (!isTRUE(labels_only)) {
  # Nothing to do!
  #}

  lynx
}