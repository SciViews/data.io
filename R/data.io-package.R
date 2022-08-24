#' @details
#' The 'data.io' package focuses on reading and writing datasets in different
#' formats in an unified and convenient format. It can deal with labels and
#' units metadata for variables, translation in different languages, and even
#' use a sidecar file for preprocessing the dataset automatically. The same
#' features are also available for a subset of datasets from R packages.
#'
#' @section Important functions:
#'
#' - [read()] is the main function to read data from R packages or files,
#'
#' - [write()] is the main function to write data to disk. It is compatible
#'   with [base::write()] but provides many more features if you indicate
#'   `type=` or use it like `write$type()`.
#'
#' - [labelise()] adds a `label`, and possibly a `units` attributes to an
#'   object, to be used while pretty printing a table or plot.
#'
#' @keywords internal
"_PACKAGE"

#' @importFrom tibble tibble tribble as_tibble is_tibble add_column
#' @importFrom tsibble as_tsibble
#' @importFrom utils .DollarNames data download.file
#' @importFrom readr default_locale read_lines
#' @importFrom rlang quos
#' @importFrom svBase default_dtx
#' @importFrom lifecycle badge deprecate_soft
# The following block is used by usethis to automatically manage
# roxygen namespace tags. Modify with care!
## usethis namespace: start
## usethis namespace: end
NULL
