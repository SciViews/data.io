#' Read data in \R in different formats
#'
#' @param file The path to the file to read, or the name of the dataset to get
#'   from an \R package (in that case, you **must** provide the `package=`
#'   argument).
#' @param type The type (format) of data to read.
#' @param header The character to use for the header and other comments.
#' @param header.max The maximum of lines to consider for the header.
#' @param skip The number of lines to skip at the beginning of the file.
#' @param locale The encoding of the file.
#' @param comments Comments to add in the created object.
#' @param package The package where to look for the dataset. If `file=` is not
#'   provided, a list of available datasets in the package is displayed.
#' @param fun The function to delegate reading of the data. If `NULL` (default),
#'   The function is chosen from `fun_list`.
#' @param fun_list The table with correspondance of the types, read, and write
#'   functions.
#' @param ... Further arguments passed to the function `fun=`.
#'
#' @description Read and return an \R object from data on disk, from URL, or
#' from packages.
#'
#' @return An \R object with the data (its class depends on the data being read).
#' @details `read()` allows for a unique entry point to read various kinds of
#' data, but it delegates the actual work to various other functions dispatched
#' accross several \R packages. See `getOption("read_write")`.
#' @author Philippe Grosjean <phgrosjean@sciviews.org>
#' @export
#' @seealso [read_csv()]
#' @keywords utilities
#' @concept read and import data
#' @examples
#' # TODO...
read <- function(file, type = NULL, header = "#", header.max = 50L, skip = 0L,
  locale = default_locale(), comments = NULL, package = NULL, fun = NULL,
  fun_list = getOption("read_write"), ...) {
  # if package is provided, get data from a package
  if (!is.null(package)) {
    if (missing(file)) {# List of datasets available in the package
      return(data(package = package))
    }
    suppressWarnings(data(list = file, package = package, ...,
      envir = environment()))
    if (!exists(file, envir = environment(), inherits = FALSE))
      stop("dataset '", file, "' not found in package '", package, "'")
    return(get(file, envir = environment(), inherits = FALSE))
  }

  if (is.null(type))
    type <- type_from_extension(file)

  # If header is not NULL, read as many lines as there are starting with this string
  if (!is.null(header) && header != "") {
    dat <- read_lines(file, n_max = header.max, skip = 0, locale = locale)
    is_header <- !cumsum(!substring(dat, 1, nchar(header)) == header)
    n_header <- sum(is_header)
    if (n_header) {
      dat <- trimws(substring(dat[1:n_header], nchar(header) + 1))
      # Eliminate empty lines
      dat <- dat[dat != ""]
      # If first line contains '---', it is probably a YAML header
      if (dat[1] == "--") {
        # TODO: how do we deal with yaml header?
      } else {# A short form of header
        # If first line starts with a ., it is the type
        if (substring(dat[1], 1, 1) == ".") {
          type <- substring(dat[1], 2)
          dat <- dat[-1]
        }
        # There may be one line without key. It is comment: by default
        if (!grepl("^[A-Za-z][A-Za-z0-9_-]*:.+$", dat[1]))
          dat[1] <- paste("comment:", dat[1])
        # Eliminate all lines not conforming withe the key: value syntax
        dat <- dat[grepl("^[A-Za-z][A-Za-z0-9_-]*:.+$", dat)]
        # Now, split the strings into key - values
        keys <- sub("^ *([A-Za-z][A-Za-z0-9_-]*) *:.+$", "\\1", dat)
        values <- sub("^ *[A-Za-z][A-Za-z0-9_-]* *: *(.+) *$", "\\1", dat)
        names(values) <- keys
        # Try to separate items for values, but first "protect" the splitting character prefixed with \

      }
    }
  }
  # Do we have a function to read these data?
  if (is.null(fun)) {
    # Get the type of the file
    if (is.null(type)) {
      # Try guessing from the extension
      # TODO: special case for URLs with more arguments!
      if (grepl("^.+\\.[a-zA-Z0-9]+$", file)) {
        type <- sub("^.+\\.([a-zA-Z0-9]+)$", "\\1", file)
        # If this is a compressed file, look further for the complete extension
        if (type %in% c("gz", "bz2", "xz", "zip") &&
            grepl("^.+\\.[a-zA-Z0-9]+\\.[a-zA-Z0-9]+$", file)) {
          type <- sub("^.+\\.([a-zA-Z0-9]+\\.[a-zA-Z0-9]+)$", "\\1", file)
        }
      }
    }
    # Is it a known type?
    if (is.null(type))
      stop("no type provided, and impossible to guess")
    if (!type %in% fun_list$type)
      stop("type '", type, "' is unknown")
    # Get the corresponding function
    fun <- fun_list$read_fun[(fun_list$type == type)]
    # In case we have ns::fun
    fun <- strsplit(fun, "::", fixed = TRUE)[[1]]
    if (length(fun) == 2) {
      fun <- getExportedValue(fun[1], fun[2])
    } else fun <- getFunction(fun[1])
  }
  # Read the data
  skip_all <- skip + n_header
  if (skip_all > 0L) {
    structure(fun(file, skip = skip + n_header, ...), comment = comments)
  } else {
    structure(fun(file, ...), comment = comments)
  }
}

#' @export
#' @rdname read
type_from_extension <- function(file) {
  # For a (compressed) .tar archive
  if (grepl("\\.([A-Za-z0-9]+)\\.tar(\\.gz|\\.xz|\\.bz2|\\.zip)?$", file))
    return(sub("^.+\\.([A-Za-z0-9]+)\\.tar(\\.gz|\\.xz|\\.bz2|\\.zip)?$", "\\1", file))

  # For a compressed file
  if (grepl("\\.([A-Za-z0-9]+)(\\.gz|\\.xz|\\.bz2|\\.zip)$", file))
    return(sub("^.+\\.([A-Za-z0-9]+)(\\.gz|\\.xz|\\.bz2|\\.zip)$", "\\1", file))

  # For a regular extension
  if (grepl("\\.([A-Za-z0-9]+)$", file))
    return(sub("^.+\\.([A-Za-z0-9]+)$", "\\1", file))

  # No rules apply
  NULL
}

options(read_write = tribble(
  ~type,     ~read_fun,            ~write_fun,
  "csv",     "readr::read_csv",    "readr::write_csv",
  "csv2",    "readr::read_csv2",   NA,
  "tsv",     "readr::read_tsv",    "readr::write_tsv",
  "csv.gz",  "readr::read_csv",     "readr::write_csv",
  "csv2.gz", "readr::read_csv2",   NA,
  "tsv.gz",  "readr::read_tsv",    "readr::write_tsv",
  "csv.bz2", "readr::read_csv",    "readr::write_csv",
  "csv2.bz2","readr::read_csv2",   NA,
  "tsv.bz2", "readr::read_tsv",    "readr::write_tsv",
  "csv.xz",  "readr::read_csv",    "readr::write_csv",
  "csv2.xz", "readr::read_csv2",   NA,
  "tsv.xz",  "readr::read_tsv",    "readr::write_tsv",
  # This is buggy right now!! "csvy",    "csvy::read_csvy",    "csvy::write_csvy",
  "xls",     "readxl::read_excel", "WriteXLS::WriteXLS",
  "xlsx",    "readxl::read_excel", "openxlsx::write.xlsx",
  "dta",     "haven::read_dta",    "write_dta",
  "por",     "haven::read_por",    "write_por",
  "sas",     "haven::read_sas",    "write_sas",
  "sav",     "haven::read_sav",    "write_sav",
  "spss",    "haven:read_spss",    NA,
  "stata",   "haven:read_stata",   NA,
  "xpt",     "haven::read_xpt",    "write_xpt",
  "feather", "feather::read_feather", "feather::write_feather"
))

# TODO: for xls/xlsx, check Openxlsx::write.xlsx, XLConnect
# TODO: check import and rio
# TODO: there is a xlsx writer in writexl, but does not support sheets!
# Note: csvy is csv with YAML header. It offers more configuration (read_csvy, write_csvy)
#library(tibble)
#library(readr)
#library(WriteXLS)
#library(write.xlsx)
#library(haven)
#library(feather)
#library(csvy)

#.import.rio_png <- function(file, native = FALSE, info = FALSE, ...) {
#  readPNG(file, native = native, info = info)
#}

# Make write an S3 method and make the base::write() function its default one
