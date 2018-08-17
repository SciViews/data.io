#' data.io - Data Input/Output, Read or Write Data from Files or Datasets in R Packages in Different Formats
#'
#' Read or write data from many different formats (tabular datasets, images, ...) into R
#' objects.
#'
#' @section Important functions:
#'
#' - [read()] is the main function to read data from R packages or files,
#'
#' - [labelise()] adds a `label`, and possibly a `units` attributes to an
#'   object, to be used while pretty printing a table or plot.
#'
#' @docType package
#' @name data-package
#'
#' @importFrom tibble tibble tribble as_tibble is_tibble add_column
#' @importFrom tsibble as_tsibble
#' @importFrom utils data
#' @importFrom readr default_locale read_lines
#' @importFrom rlang quos
NULL