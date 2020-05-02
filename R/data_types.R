#' List recognized file formats (types) for read() and write()
#'
#' @param types_only If `TRUE`, only a vector of types is returned, otherwise,
#' a `tibble` with full specifications is provided.
#' @param view If `TRUE`, the result is "viewed" (displayed in a table in a
#' separate window, if the user interface allows it, e.g., in RStudio) and
#' returned invisibly. Otherwise, the results are returned normally.
#'
#' @description Display information about data types that can read() and write()
#' can use, as well as, the original functions that are delegated (see they
#' respective help pages for more info and to know which additional parameters
#' can be used in read() and write()).
#'
#' @return An `tibble` with `types_only = FALSE`, or a character vector.
#' @details The function is mainly designed to be used interactively and to
#' provide information about file types that can be read() or write(). This
#' cannot be done through a man page because this list is dynamic and other
#' packages could add or change entries there. With `view = FALSE`, the function
#' can, nevertheless, be also used in a script or a R Markdown/Notebook
#' document.
#' @author Philippe Grosjean <phgrosjean@sciviews.org>
#' @export
#' @seealso [read()], [write()]
#' @keywords utilities
#' @concept list file types that can be read or write
#' @examples
#' \dontrun{
#' data_types()
#' data_types(TRUE)
#' }
#' # For non-interactive use, specify view = FALSE
#' data_types(view = FALSE)
#' data_types(TRUE, view = FALSE)
data_types <- function(types_only = FALSE, view = TRUE) {
  `data types` <- getOption("read_write")
  # If not installed yet, do it now!
  if (is.null(`data types`))
    `data types` <- read_write_option()

  if (isTRUE(types_only))
    `data types` <- `data types`$type

  if (isTRUE(view)) {
    # We don't necessarily want to use utils::View(). For instance, RStudio
    # defines another version of that function, and we ant to use it instead!
    view <- get0("View", mode = "function")
    if (is.null(view)) {
      warning("'View' function not found, return the data instead")
      `data types`
    } else {
      view(`data types`)
      invisible(`data types`)
    }
  } else `data types`
}

