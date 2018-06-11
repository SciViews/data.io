#' Convert objects into dataframes (subclassing tibble) and check for it.
#'
#' @param x An object to convert to a `dataframe`.
#' @param ... Additional parameters.
#'
#' @description Convert an object into a `dataframe` and check for it. A
#' `dataframe` (without dot) is both a `data.frame` (with dot, the default
#' rectangular dataset structure in R) and a `tibble`, the tidyverse
#' equivalence. In fact, `dataframe`s behave almost completely like a `tibble`,
#' except for a few details explained in the **details** section.
#'
#' @return A `dataframe`, which is an S3 object with class
#'   `c("dataframe", "tbl_df", "tbl", "data.frame")`.
#' @details TODO: explain difference beteen `dataframe`s and `tibble`s here...
#' @author Philippe Grosjean <phgrosjean@sciviews.org>
#' @export
#' @seealso [as_tibble()], [as.data.frame()]
#' @keywords utilities
#' @concept convert objects
#' @examples
#' class(as.dataframe(mtcars))
#' class(as.dataframe(tibble::tribble(~x, ~y, 1, 2, 3, 4)))
#' # Any object, like a vector
#' v1 <- 1:10
#' is_dataframe(v1)
#' (df1 <- as_dataframe(v1))
#' is_dataframe(df1)
#' # Validate an existing dataframe
#' (as_dataframe(df1, validate = TRUE))
#' # A data.frame with trivial row names
#' datasets::iris
#' as_dataframe(datasets::iris)
#' # A data.frame containing meaningful row names
#' datasets::mtcars
#' as_dataframe(datasets::mtcars)
#' # A list
#' l1 <- list(x = 1:3, y = rnorm(3))
#' as_dataframe(l1)
#' # A matrix with column and row names
#' (m1 <- matrix(1:9, nrow = 3L, dimnames = list(letters[1:3], LETTERS[1:3])))
#' as_dataframe(m1)
#' # A table
#' set.seed(756)
#' (t1 <- table(sample(letters[1:5], 50, replace = TRUE)))
#' as_dataframe(t1)
#' # compare with the base R function:
#' as.data.frame(t1)
as_dataframe <- function(x, ...)
  UseMethod("as_dataframe")

#' @export
#' @rdname as_dataframe
as.dataframe <- as_dataframe

#' @export
#' @rdname as_dataframe
#' @param tz The time zone. Useful for converting `ts` objects with observations
#' more frequent than daily.
as_dataframe.default <- function(x, tz = "UTC", ...) {
  # If we have time series objects, transform first into tsibble
  if (inherits(x, c("ts", "mts", "hts", "msts", "grouped_ts")))
    x <- as_tsibble(x, tz = tz, gather = FALSE, ...)
  x <- as_tibble(x, ...)
  if (is_tibble(x)) {
    class(x) <- unique(c("dataframe", class(x)))
  } else {
    stop("don't know how to convert this object into a dataframe")
  }
  x
}

#' @export
#' @rdname as_dataframe
#' @param rownames Name of the column that is prepended to the
#'   `dataframe` with the original row names (`dataframe`s and `tibble`s do not
#'   support row names). If `NULL`, row names are dropped. The inclusion of the
#'   rownames column is **not** done if row names are trivials, i.e., they equal
#'   the number of the rows in the data frame.
as_dataframe.data.frame <- function(x, ..., rownames = "rownames") {
  # Creating a new "rownames" column in case of non-trivial row names
  nr <- NROW(x)
  rnames <- rownames(x)
  if (!is.null(rownames) && length(rownames) && nr && any(rnames != 1:nr)) {
    x <- data.frame(..rownames.. = rnames, x, stringsAsFactors = FALSE)
    x_names <- names(x)
    x_names[1] <- as.character(rownames)[1]
    names(x) <- x_names
  }
  # Transform into a tibble
  x <- as_tibble(x, rownames = NULL, ...)
  class(x) <- unique(c("dataframe", class(x)))
  x
}

#' @export
#' @rdname as_dataframe
#' @param validate Do we validate the `dataframe` (check its structure is
#'   correct)?
as_dataframe.dataframe <- function(x, ..., validate = FALSE,
rownames = "rownames") {
  if (isTRUE(validate)) {
    NextMethod()
  } else x
}

#' @export
#' @rdname as_dataframe
as_dataframe.list <- function(x, validate = FALSE, ...) {
  x <- as_tibble(x, validate = validate, ...)
  class(x) <- unique(c("dataframe", class(x)))
  x
}

#' @export
#' @rdname as_dataframe
as_dataframe.matrix <- function(x, ..., rownames = "rownames") {
  x <- as_tibble(x, ..., rownames = rownames)
  class(x) <- unique(c("dataframe", class(x)))
  x
}

#' @export
#' @rdname as_dataframe
#' @param n The name for the column containing the number of items, `"n"` by
#'   default.
as_dataframe.table <- function(x, n = "n", ...) {
  x <- as_tibble(x, n = n, ...)
  class(x) <- unique(c("dataframe", class(x)))
  x
}

# TODO: as.data.frame.dataframe, as.tibble.dataframe, as.data.table.dataframe,
# as.list.dataframe, ... but most of this is already handled by other methods!

#' @export
#' @rdname as_dataframe
is_dataframe <- function(x)
  inherits(x, "dataframe")

#' @export
#' @rdname as_dataframe
is.dataframe <- is_dataframe

# TODO: check all this!
#dataframe <- function(..., .data = NULL, .before = NULL, .after = NULL) {
#  # TODO: check .before and .after!
#  xs <- quos(..., .named = TRUE)
#  if (!is.null(.data)) {
#    res <- add_column(tribble(.data), ..., .before = .before, .after = .after)
#  } else {
#    # TODO: lst_quos') is not exported from tibble
#    res <- as_tibble(lst_quos(xs, expand = TRUE))
#  }
#  class(res) <- unique(c("dataframe", class(res)))
#  res
#}

# Also interesting from tibble:
# - new_tibble allow to subclass!!! => use it instead!
#
# - glimpse(): should be nice to have an enhanced version, also for summary()
#
# - add_column(), add_row(): works unmodified with dataframe
#
# - has_rownames(), remove_rownames(), column_to_rownames(),
#   rownames_to_column() & rowid_to_column() to cope with the rownames in
#   data.frame, but not in tibble or data.table or dataframe
#
# - deframe(), enframe()
#
# - set_tidy_names(), tidy_names() & repair_names() for better names.
#
# - trunc_mat() and knit_print.trunc_mat() are used to default display of tibble
#
# - has_name() from rlang, type_sum(), obj_sum() & is_vector_s3() from pillar
#   but see also tbl_sum()
#
# - frame_matrix is like tribble for matrices => combine with matrix()?
#
# - lst() is like list() but evaluates its arguments like tibble()

# Trials for further dataframe enhancement
# $ that allow for glue's replacement + df$.(args) syntax
#`$.dataframe` <- function(x, i) {
#  i <- glue(i, .open = ".(", .close = ")")
#  #cat(i, "\n")
#  if (i ==  ".")
#    return(function(name) do.call("$", list(x, name)))
#  NextMethod()
#}
# Test
#library(data)
#urchin <- read("urchin_bio", package = "data")
#class(urchin)
#library(glue)
#myvar <- "test"
#glue(".(myvar)", .open = ".(", .close = ")")
#urchin$test
#urchin$".(myvar)" # Could be nice to have this!
#urchin$.(myvar)

#`[.dataframe` <- function(x, i, j, ..., drop = FALSE) {
#
#}

# A special verb to perform data.table by ref transformation on a dataframe
#alter <- function(x, ...)
#  UseMethod("alter")
#
#alter.default <- function(x, ...)
#  stop("Don't know how to alter this object")
#
#alter.dataframe <- function(x, i, j, by = group_vars(x), ...) {
#  # Transform into a data.table before performing a [] operation on it!
#  classes <- class(x)
#
#  on.exit({
#    if (is.data.frame(x)) {
#      x <- as.dataframe(data.table::setDF(x)) # Converts back into a dataframe
#      class(x) <- classes # with the sames classes (in case it was subclassed)
#    }
#  })
#
#  x <- data.table::setDT(x, key = attr(x, "key"))
#  if (length(by)) {
#    x[i, j, by = by, ...]
#  } else {
#    x[i, j, ...]
#  }
#}
# The data.table operators do not work here!!
#alter(urchin, "test")
#alter(urchin, test)
