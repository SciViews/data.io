#' Get the path to some example datasets in this package
#'
#' @param path The subpath to a file inside the "extdata" subdirectory of the
#' "data.io" package.
#'
#' @description Get the full path to so example datasets included in different
#' formats in the "data.io" package.
#'
#' @return The path to the file, or "" if it is not found.
#' @author Philippe Grosjean <phgrosjean@sciviews.org>
#' @export
#' @seealso [read()]
#' @keywords utilities
#' @concept get package directory
#' @examples
#' data_example("iris.csv")
data_example <- function(path)
  system.file("extdata", path, package = "data.io", mustWork = TRUE)