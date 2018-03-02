# Both Hmisc and haven define 'labelled' S3 objects, but they are different and
# serve different purposes (and are incompatibles)!
# We want the label version of Hmisc, but creating a 'labelling' S3  object
# instead.

#' Set label (and units)
#'
#' @param x An object.
#' @param label The character string to set as `label` attribute to `x`.
#' @param units The units (optional) as a character string to set for `x`.
#' @param as.labelled Should the object be converted as a `labelled` S3 object
#' (no by default)?
#' @param ... Further arguments: itesm to be concatenated in a vector using
#' `c(...)` for `cl()`.
#'
#' @description Set the `label`, as well as the `units` attributes to an object.
#' The label can be used for better display as plot axes labels, or as table
#' headers in pretty-formatted \R outputs. The units are usually associated to
#' the label in axes labels for plots. `cl()` is a shortcut for concatenate
#' (`c()`) and `set_label()`.
#'
#' @return The `x` object plus a `label` attribute, and possibly, a `units`
#' attribute.
#' @details The same mechanism as the one used in package **Hmisc** is used
#' here. However, **Hmisc** always add the **labelled** class to an object,
#' while here, this is optional. Setting this class make the object more nicely
#' printed, and subsettable without loosing these attributes. But it conflicts
#' with a class of the same name in package **haven**, used for other purposes.
#' So, here, the class is **not** set by default.
#' @author Philippe Grosjean <phgrosjean@sciviews.org>
#' @export
#' @seealso [label()], [units()]
#' @keywords utilities
#' @concept labelling objects
#' @examples
#' # TODO...
set_label <- function(x, label, units = NULL, as.labelled = FALSE, ...) {
  if (!is.null(label)) {
    if (is.list(label))
      stop("cannot assign a list to be a object label")
    if (length(label) != 1L)
      stop("label must be character vector of length 1")
    attr(x, "label") <- label
    if (isTRUE(as.labelled) && !"labelled" %in% class(x))
      class(x) <- c("labelled", class(x))
  }

  if (!missing(units))
    units(x) <- units
  x
}

#' @export
#' @rdname set_label
cl <- function(..., label = NULL, units = NULL, as.labelled = FALSE)
  set_label(c(...), label = label, units = units, as.labelled = as.labelled)

#' @importFrom Hmisc label
#' @export
Hmisc::label

#' @importFrom Hmisc label<-
#' @export
Hmisc::`label<-`

#' @importFrom Hmisc units
#' @export
Hmisc::units

