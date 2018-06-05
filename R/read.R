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
#' @param sidecar_file If `TRUE` and a file with same name as `file=` + `.R` is
#'   found in the same directory, it is considered as code to import these data
#'   and it is sourced with `local = TRUE`, `chdir = TRUE` and
#'   `verbose = FALSE`. That script **must** create an object named `dataset`,
#'   which is the result that is returned by the function.
#' @param hfun The function to read the header (lines starting with a special
#'   mark, usually '#' at the beginning of the file). This function must have
#'   the same arguments as `hread_text()` and should return a character string
#'   with the first `header.max` lines.
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
#' # Use of read() as a more flexible substitute to data() (can change dataset
#' # name and syntax more similar to read R datasets and datasets from files)
#' read() # List all available datasets in your installed version of R
#' # List datasets in one particular package
#' read(package = "data")
#' # Read one dataset from an R package, possibly changing its name
#' (urchin <- read("urchin_bio", package = "data"))
#'
#' # Many example data files in the /extdata subdirectory of the package
#' data_example <- function(path)
#'   system.file("extdata", path, package = "data", mustWork = TRUE)
#'
#' # Various versions of the famous iris dataset
#' (iris <- read(data_example("iris.csv")))
#' (iris <- read(data_example("iris.csv.zip")))
#' (iris <- read(data_example("iris.csv.tar"))) ##
#' (iris <- read(data_example("iris.csv.tar.gz"))) ##
#' (iris <- read(data_example("iris.csv.gz")))
#' (iris <- read(data_example("iris.csv.bz2")))
#' #(iris <- read(data_example("iris.csv.7z"))) ##
#' (iris <- read(data_example("iris.tsv")))
#' (iris <- read(data_example("iris.xls")))
#' (iris <- read(data_example("iris.xlsx")))
#' (iris <- read(data_example("iris.rds"))) # Does not tranform into tibble!
#' #(iris <- read(data_example("iris.syd"))) ##
#' (iris <- read(data_example("iris_short_header.csv"))) ##
#' #(iris <- read(data_example("iris.csvy"))) ##
#' #(iris <- read(data_example("iris.csvy.zip"))) ##
#'
#' # Require the feather package
#' (iris <- read(data_example("iris.feather")))
#'
#' # Challenging datasets from the readr package
#' library(readr)
#' (mtcars <- read(readr_example("mtcars.csv")))
#' (mtcars <- read(readr_example("mtcars.csv.zip")))
#' (mtcars <- read(readr_example("mtcars.csv.bz2")))
#' (challenge <- read(readr_example("challenge.csv"), guess_max = 1001))
#' (massey <- read(readr_example("massey-rating.txt")))
#' # By default, the type cannot be guessed from the extension
#' # This is a space-separated vaules file (ssv)
#' (massey <- read(readr_example("massey-rating.txt"), type = "ssv"))
#' # or ...
#' (massey <- read$ssv(readr_example("massey-rating.txt")))
#' (epa <- read$ssv(readr_example("epa78.txt"), col_names = FALSE))
#' (example_log <- read(readr_example("example.log")))
#' # There are different ways to specify columns for fixed-width files (fwf)
#' # See ?read_fwf in package readr
#' (fwf_sample <- read$fwf(readr_example("fwf-sample.txt"),
#'    col_positions =  fwf_cols(name = 20, state = 10, ssn = 12)))
#'
#' # Various examples of Excel datasets from readxl
#' library(readxl)
#' (xl <- read(readxl_example("datasets.xls")))
#' (xl <- read(readxl_example("datasets.xlsx"), sheet = "mtcars"))
#' (xl <- read(readxl_example("datasets.xlsx"), sheet = 3))
#' # Accomodate a column with disparate types via col_type = "list"
#' (clip <- read(readxl_example("clippy.xls"), col_types = c("text", "list")))
#' (clip <- read(readxl_example("clippy.xlsx"), col_types = c("text", "list")))
#' tibble::deframe(clip)
#' # Read from a specific range in a sheet
#' (xl <- read(readxl_example("datasets.xlsx"), range = "mtcars!B1:D5"))
#' (deaths <- read(readxl_example("deaths.xls"), range = cell_rows(5:15)))
#' (deaths <- read(readxl_example("deaths.xlsx"), range = cell_rows(5:15)))
#' (type_me <- read(readxl_example("type-me.xls"), sheet = "logical_coercion",
#'   col_types = c("logical", "text")))
#' (type_me <- read(readxl_example("type-me.xlsx"), sheet = "numeric_coercion",
#'   col_types = c("numeric", "text")))
#' (type_me <- read(readxl_example("type-me.xls"), sheet = "date_coercion",
#'   col_types = c("date", "text")))
#' (type_me <- read(readxl_example("type-me.xlsx"), sheet = "text_coercion",
#'   col_types = c("text", "text")))
#' (xl <- read(readxl_example("geometry.xls"), col_names = FALSE))
#' (xl <- read(readxl_example("geometry.xlsx"), range = cell_rows(4:8)))
#'
#' # Various examples from haven
#' library(haven)
#' haven_example <- function(path)
#'   system.file("examples", path, package = "haven", mustWork = TRUE)
#' (iris2 <- read(haven_example("iris.dta"))) # Stata v. 8-14
#' (iris2 <- read(haven_example("iris.sav"))) # SPSS, TODO: labelled -> factor?
#' (pbc <- read(data_example("pbc.por"))) # SPSS, POR format
#' (iris2 <- read$sas(haven_example("iris.sas7bdat"))) # SAS file
#' (afalfa <- read(data_example("afalfa.xpt"))) # SAS transport file
read <- structure(function(file, type = NULL, header = "#", header.max = 50L,
  skip = 0L, locale = default_locale(), comments = NULL, package = NULL,
  sidecar_file = TRUE, hfun = NULL, fun = NULL, fun_list = NULL, ...) {
  # Is there a sidecar file?
  if (missing(file)) {
    if (missing(package)) # No file or package provided: list all datasets
      return(data())
    file2 <- ""
  } else {
    file2 <- paste0(file, ".R")
  }
  if (isTRUE(sidecar_file) && file.exists(file2)) {
    # Use a fake dataset content: it is supposed to be modified by the script
    dataset <- NULL
    source(file2, local = TRUE, chdir = TRUE, verbose = FALSE)
    if (is.null(dataset))
      stop("The script '", basename(file2),
        "' did not produce a valid 'dataset' object.",
        " Is it really a sidecar file?")
    return(dataset)
  }

  # Get fun_list from options() (and possibly install it)
  if (is.null(fun_list))
    fun_list <- getOption("read_write")
  # If not installed yet, do it now!
  if (is.null(fun_list)) {
    .install_read_write_options()
    fun_list <- getOption("read_write")
  }
  # If package is provided, get data from a package
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
  # Do we need type to get fun or hfun, and is it a known type?
  if (is.null(fun) || is.null(hfun)) {
    if (is.null(type))
      stop("no type provided, and impossible to guess")
    if (!type %in% fun_list$type) {
      stop("type '", type, "' is unknown")
    } else fun_item <- fun_list[fun_list$type == type, ]
  }

  # If header is not NULL and a hread_xxx() function is available,
  # read as many lines as there are starting with this string
  # and decrypt header data/metadata
  if (is.null(hfun))
      hfun <- .get_function(fun_item$read_header)
  if (is.function(hfun) && !is.null(header) && header != "") {
    dat <- hfun(file = file, header.max = header.max, skip = skip,
      locale = locale)
    dat[is.na(dat)] <- FALSE
    is_header <- !cumsum(!substring(dat, 1L, nchar(header)) == header)
    n_header <- sum(is_header)
    if (n_header) {
      dat <- trimws(substring(dat[1:n_header], nchar(header) + 1))
      # Eliminate empty lines
      dat <- dat[dat != ""]
      # If first line contains '---', it is probably a YAML header
      if (dat[1L] == "--") {
        # TODO: how do we deal with yaml header?
      } else {# A short form of header
        # If first line starts with a ., it is the type
        if (substring(dat[1L], 1L, 1L) == ".") {
          type <- substring(dat[1L], 2L)
          dat <- dat[-1L]
        }
        # There may be one line without key. It is comment: by default
        if (!grepl("^[A-Za-z][A-Za-z0-9_-]*:.+$", dat[1]))
          dat[1L] <- paste("comment:", dat[1])
        # Eliminate all lines not conforming withe the key: value syntax
        dat <- dat[grepl("^[A-Za-z][A-Za-z0-9_-]*:.+$", dat)]
        # Now, split the strings into key - values
        keys <- sub("^ *([A-Za-z][A-Za-z0-9_-]*) *:.+$", "\\1", dat)
        values <- sub("^ *[A-Za-z][A-Za-z0-9_-]* *: *(.+) *$", "\\1", dat)
        names(values) <- keys
        # Try to separate items for values, but first "protect" the splitting character prefixed with \

      }
    }
  } else n_header <- 0L

  # Do we have a function to read these data?
  if (is.null(fun))
    fun <- .get_function(fun_item$read_fun)

  # Read the data
  skip_all <- skip + n_header
  if (skip_all > 0L) {
    structure(fun(file, skip = skip + n_header, ...), comment = comments)
  } else {
    structure(fun(file, ...), comment = comments)
  }
}, class = c("subsettable_type", "function"))

.get_function <- function(fun) {
  # In case we have ns::fun
  fun <- strsplit(fun, "::", fixed = TRUE)[[1L]]
  if (length(fun) == 2L) {
    res <- try(getExportedValue(fun[1L], fun[2L]), silent = TRUE)
    if (inherits(res, "try-error"))
      stop("You need function '", fun[2L], "' from package '", fun[1L],
        "' to read these data. Please, install the package first",
        " and make sure the function is available there.")
  } else {
    if (is.na(fun[1L]))
      return(NA)
    res <- get0(fun[1L], envir = parent.frame(), mode = "function",
      inherits = TRUE)
    if (is.null(res))
      stop("function '", fun[1], "' not found")
  }
  res
}

#' @export
#' @rdname read
type_from_extension <- function(file) {
  # TODO: special case for URLs with more arguments!

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

#' @export
#' @rdname read
hread_text <- function(file, header.max, skip = 0L, locale = default_locale(),
...)
  read_lines(file, n_max = header.max, skip = skip, locale = locale, ...)

#' @export
#' @rdname read
hread_xls <- function(file, header.max, skip = 0L, locale = default_locale(),
...) {
  res <- readxl::read_xls(file, range = paste0("A1:A", header.max),
    col_types = "text", col_names = FALSE, ...)
  if (!ncol(res)) character(0) else res[[1L]]
}

#' @export
#' @rdname read
hread_xlsx <- function(file, header.max, skip = 0L, locale = default_locale(),
...) {
  res <- readxl::read_xlsx(file, range = paste0("A1:A", header.max),
    col_types = "text", col_names = FALSE, ...)
  if (!ncol(res)) character(0) else res[[1L]]
}

#' @export
#' @rdname read
#' @param x A `subsettable_type` function.
#' @param name The value to use for the `type=` argument.
#' @method $ subsettable_type
`$.subsettable_type` <- function(x, name)
  function(...) x(type = name, ...)


# Private functions -------------------------------------------------------

.install_read_write_options <- function() {
  options(read_write = tibble::tribble(
    ~type,     ~read_fun,              ~read_header,
    ~write_fun,
    "csv",     "readr::read_csv",      "data::hread_text",
    "readr::write_csv",
    "csv2",    "readr::read_csv2",     "data::hread_text",
    NA,
    "xlcsv",   "readr::read_csv",      "data::hread_text",
    "readr::write_excel_csv",
    "tsv",     "readr::read_tsv",      "data::hread_text",
    "readr::write_tsv",
    "fwf",     "readr::read_fwf",      "data::hread_text",
    NA, # TODO: a writer here!
    "log",     "readr::read_log",      NA,
    NA, # TODO: a writer here!
    "rds",     "readr::read_rds",      NA,
    "readr::write_rds",
    "txt",     "readr::read_file",     NA,
    "readr::write_file",
    "raw",     "readr::read_file_raw", NA,
    NA, # TODO: a writer here!
    "ssv",     "readr::read_table",    "data::hread_text",
    NA,#Space separated values
    "ssv2",    "readr::read_table2",   "data::hread_text",
    NA,
    "csv.gz",  "readr::read_csv",      "data::hread_text",
    "readr::write_csv",
    "csv2.gz", "readr::read_csv2",     "data::hread_text",
    NA,
    "tsv.gz",  "readr::read_tsv",      "data::hread_text",
    "readr::write_tsv",
    "txt.gz",  "readr::read_file",     NA,
    "readr::write_file",
    "csv.bz2", "readr::read_csv",      "data::hread_text",
    "readr::write_csv",
    "csv2.bz2","readr::read_csv2",     "data::hread_text",
    NA,
    "tsv.bz2", "readr::read_tsv",      "data::hread_text",
    "readr::write_tsv",
    "txt.bz2", "readr::read_file",     "data::hread_text",
    "readr::write_file",
    "csv.xz",  "readr::read_csv",      "data::hread_text",
    "readr::write_csv",
    "csv2.xz", "readr::read_csv2",     "data::hread_text",
    NA,
    "tsv.xz",  "readr::read_tsv",      "data::hread_text",
    "readr::write_tsv",
    "txt.xz",  "readr::read_file",     NA,
    "readr::write_file",
    # Buggy right now!! "csvy",    "csvy::read_csvy",    NA, "csvy::write_csvy",
    "xls",     "readxl::read_excel",   "data::hread_xls",
    "WriteXLS::WriteXLS",
    "xlsx",    "readxl::read_excel",   "data::hread_xlsx",
    "openxlsx::write.xlsx",
    "dta",     "haven::read_dta",      NA,
    "haven::write_dta",
    # read_dta() = read_stata()
    "sas",     "haven::read_sas",      NA,
    "haven::write_sas",
    "sas7bdat","haven::read_sas",      NA,
    "haven::write_sas",
    "sav",     "haven::read_sav",      NA,
    "haven::write_sav",
    "por",     "haven::read_por",      NA,
    NA,
    # read_por()/read_sav() = read_spss()
    "xpt",     "haven::read_xpt",      NA,
    "haven::write_xpt",
    "feather", "feather::read_feather",NA,
    "feather::write_feather"
  ))
}

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
