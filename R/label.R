# Both Hmisc and haven define 'labelled' S3 objects, but they are different and
# serve different purposes (and are incompatibles)!
# We want the label version of Hmisc, but creating a 'labelled' S3  object
# instead.
# Also labelVector defines set_label() and get_label() but only for atomic
# objects (no lists) and enforce the labelled class, and does not handle units.
# Our labelise()/labelize() function deals with units and does not necessarily
# enforces the class (and works with any object, except NULL).

#' Set label (and units)
#'
#' @param x An object.
#' @param label The character string to set as `label` attribute to `x`.
#' @param units The units (optional) as a character string to set for `x`.
#' @param as_labelled Should the object be converted as a `labelled` S3 object
#' (by default)? If you don't make labelled objects, subsetting the data will
#' lead to a lost of `label` and `units` attributes for all variables.
#' @param ... Further arguments: itesm to be concatenated in a vector using
#' `c(...)` for `cl()`.
#'
#' @description Set the `label`, as well as the `units` attributes to an object.
#' The label can be used for better display as plot axes labels, or as table
#' headers in pretty-formatted \R outputs. The units are usually associated to
#' the label in axes labels for plots. `cl()` is a shortcut for concatenate
#' (`c()`) and `labelise()`.
#'
#' @return The `x` object plus a `label` attribute, and possibly, a `units`
#' attribute.
#' @details The same mechanism as the one used in package **Hmisc** is used
#' here. However, **Hmisc** always add the **labelled** class to an object,
#' while here, this is optional. Setting this class make the object more nicely
#' printed, and subsettable without loosing these attributes. But it conflicts
#' with a class of the same name in package **haven**, used for other purposes.
#' So, here, one can also opt not to set it, using `as_labelled = FALSE`.
#' @author Philippe Grosjean <phgrosjean@sciviews.org>
#' @export
#' @seealso [label()], [units()]
#' @keywords utilities
#' @concept labelling objects
#' @examples
#' # Labelise a vector:
#' x <- 1:10
#' x <- labelise(x, label = "A suite of integers", units = "cm")
#' x
#' # or, in a single operation:
#' x <- cl(1:10, label = "A suite of integers", units = "cm")
#' x
#' # Not adding the labelled class:
#' x <- cl(1:10, label = "Integers", units = "cm", as_labelled = FALSE)
#' x
#' # Unlabelising a labelised object
#' unlabelise(x)
#'
#' # Labelise a data.frame
#' iris <- labelise(datasets::iris, "The famous iris dataset")
#' unlabelise(iris)
#' # but if you indicate self = FALSE, you can labelise variables within the
#' # data.frame (use a list or character vector of same length as x, or a
#' # named list or character vector):
#' iris <- labelise(iris, self = FALSE, label = list(
#'   Sepal.Length = "Length of the sepals",
#'   Petal.Length = "Length of the petals"
#'   ), units = c(rep("cm", 4), NA))
#' iris <- unlabelise(iris, self = FALSE)
labelise <- function(x, label, units = NULL, as_labelled = TRUE, ...)
  UseMethod("labelise")

#' @export
#' @rdname labelise
labelize <- labelise

#' @export
#' @rdname labelise
#' @method labelise default
`labelise.default` <- function(x, label, units = NULL, as_labelled = TRUE,
...) {
  if (!is.null(label) && !is.na(label)) {
    if (is.list(label))
      stop("cannot assign a list to be a object label")
    if (length(label) != 1L)
      stop("label must be character vector of length 1")
    attr(x, "label") <- label
    if (isTRUE(as_labelled) && !"labelled" %in% class(x))
      class(x) <- c("labelled", class(x))
  }

  if (!is.null(units) && !is.na(units))
    units(x) <- units
  x
}

#' @export
#' @rdname labelise
#' @param self Do we label the `data.frame` itself (`self = TRUE`, by default)
#'   or variables within that `data.frame` (`self = FALSE`)? In the later case,
#'   `label=` and `units=` must be either lists or character vectors of the same
#'   length as `x`, or be named with the names of several or all `x` variables.
#' @method labelise data.frame
`labelise.data.frame` <- function(x, label, units = NULL, as_labelled = TRUE,
self = TRUE, ...) {
  if (!is.data.frame(x))
    stop("x must be a data.frame")

  if (missing(self) && is.list(label))
    self <- FALSE

  if (isTRUE(self)) {
    xc <- class(x)
    xx <- unclass(x)
    xx <- labelise(xx, label = label, units = units, as.labelled = FALSE,
      self = TRUE, ...)
    if (isTRUE(as_labelled) && !"labelled" %in% xc) {
      class(xx) <- c("labelled", xc)
    } else {
      class(xx) <- xc
    }
    x <- xx
  } else {# self = FALSE, label variables within the data.frame
    nc <- ncol(x)
    if (nc == 0) {
      warning("Impossible to label variables of a data.frame with no columns")
      return(x)
    }
    vars <- names(x)
    if (is.character(label))
      label <- as.list(label)
    lvars <- names(label)
    if (is.null(lvars)) {
      if (length(label) != nc)
        stop("label as unnamed list must have the same length as x")
      names(labels) <- vars
    } else {# Named list: all items must be named and match names in x
      missing_lvars <- lvars[!lvars %in% vars]
      if (length(missing_lvars))
        stop("The following label names are not in `x`: ",
          paste0(missing_lvars, collapse = ", "))
      label <- label[vars]
      names(label) <- vars
    }
    if (is.null(units)) {
      units <- as.list(rep(NA, nc))
      names(units) <- vars
    } else if (!is.list(units) && !is.character(units)) {
      stop("units must be a list or character vector of same length as x")
    } else {
      if (is.character(units))
        units <- as.list(units)
      uvars <- names(units)
      if (is.null(uvars)) {
        if (length(units) != nc)
          stop("units as unnamed list must have the same length as x")
        names(units) <- vars
      } else {# Named list: all items must be named and match names in x
        missing_uvars <- uvars[!uvars %in% vars]
        if (length(missing_uvars))
          stop("The following units names are not in `x`: ",
            paste0(missing_uvars, collapse = ", "))
        units <- units[vars]
        names(units) <- vars
      }
    }
    for (i in seq(along.with = x)) {
      x[[i]] <- labelise(x[[i]], label = label[[i]], units = units[[i]],
        as.labelled = as_labelled, self = TRUE, ...)
    }
  }
  x
}

#' @export
#' @rdname labelise
cl <- function(..., label = NULL, units = NULL, as_labelled = TRUE)
  labelise(c(...), label = label, units = units, as_labelled = as_labelled)

#' @export
#' @rdname labelise
unlabelise <- function(x, ...)
  UseMethod("unlabelise")

#' @export
#' @rdname labelise
unlabelize <- unlabelise

#' @export
#' @rdname labelise
#' @method unlabelise default
`unlabelise.default` <- function(x, ...) {
  attr(x, "label") <- NULL
  units(x) <- NULL
  cl <- class(x)
  class(x) <- cl[cl != "labelled"]
  x
}

#' @export
#' @rdname labelise
#' @method unlabelise data.frame
`unlabelise.data.frame` <- function(x, self = TRUE, ...) {
  if (!is.data.frame(x))
    stop("x must be a data.frame")

  if (isTRUE(self)) {
    attr(x, "label") <- NULL
    units(x) <- NULL
    cl <- class(x)
    class(x) <- cl[cl != "labelled"]
  } else {# self = FALSE, unlabelise variables within the data.frame
    x <- lapply(x, unlabelise)
  }
  x
}

#' @importFrom Hmisc label
#' @export
Hmisc::label

#' @importFrom Hmisc label<-
#' @export
Hmisc::`label<-`
# TODO: allow to assign NULL too, to eliminate the label!

# Don't do that! units is already defined in base and is fine from there!
##' @importFrom Hmisc units
##' @export
#Hmisc::units

