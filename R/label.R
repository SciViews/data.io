# Both Hmisc and haven define 'labelled' S3 objects, but they are different and
# serve different purposes (and are incompatibles)!
# We want the label version of Hmisc, but creating a 'labelling' S3  object
# instead.

# We should reexport Hmisc units units.default units<-, units<-.default
# We should reexport label, but change label<-.default to **not** return a class!

#' @importFrom Hmisc label label<- units units<-
#' @export
Hmisc::label

#' @export
#' @rdname label
Hmisc::`label<-`

#' @export
#' @rdname label
set_label <- function(x, label, units = NULL, as.labelled = FALSE, ...) {
  # On the contrary to
  if (is.list(label)) {
    stop("cannot assign a list to be a object label")
  }
  if (length(label) != 1L) {
    stop("label must be character vector of length 1")
  }
  attr(x, "label") <- label
  if (isTRUE(as.labelled) && !"labelled" %in% class(x))
    class(x) <- c("labelled", class(x))

  if (!missing(units))
    units(x) <- units
  x
}

#' @export
#' @rdname label
Hmisc::units

