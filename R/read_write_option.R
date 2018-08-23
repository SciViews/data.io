#' Define default read/write options and add items to it
#'
#' @param new_type A data.frame with four columns: `type`, `read_fun`,
#'   `read_header` & `write_fun` containing each a single character string or
#'   `NA`. `type` is the usual extension for this type of file, e.g., `png` for
#'   PNG images, `read_fun`, `read_header` & `write_fun` are character strings
#'   with "<pkg>::<fun>" format (<pkg> is the package containing the
#'   function and <fun> is the function name), or just "<fun>" if the function
#'   is visible on the search path.
#'
#' @description Define the functions that [read()] or write() must call to
#' import or export data for the different types (formats).
#'
#' @return The data.frame with all known formats is returned invisibly. The same
#' data.frame is also savec in the "read_write" option, and can be retrieved
#' directly with `getOption("read_write")`.
#' @author Philippe Grosjean <phgrosjean@sciviews.org>
#' @export
#' @seealso [read()], [getOption()]
#' @keywords utilities
#' @concept labelling objects
#' @examples
#' # The default options
#' (read_write_option())
#' # To add a new type:
#' tail(read_write_option(data.frame(type = "png", read_fun = "png::readPNG",
#'   read_header = NA, write_fun = "png::writePNG")))
read_write_option <- function(new_type) {
  opts <- getOption("read_write", default = tibble::tribble(
    ~type,     ~read_fun,              ~read_header,
    ~write_fun,
    "csv",     "readr::read_csv",      "data.io::hread_text",
    "readr::write_csv",
    "csv2",    "readr::read_csv2",     "data.io::hread_text",
    NA,
    "xlcsv",   "readr::read_csv",      "data.io::hread_text",
    "readr::write_excel_csv",
    "tsv",     "readr::read_tsv",      "data.io::hread_text",
    "readr::write_tsv",
    "fwf",     "readr::read_fwf",      "data.io::hread_text",
    NA, # TODO: a writer here!
    "log",     "readr::read_log",      NA,
    NA, # TODO: a writer here!
    "rds",     "readr::read_rds",      NA,
    "readr::write_rds",
    "txt",     "readr::read_file",     NA,
    "readr::write_file",
    "raw",     "readr::read_file_raw", NA,
    NA, # TODO: a writer here!
    "ssv",     "readr::read_table",    "data.io::hread_text",
    NA,#Space separated values
    "ssv2",    "readr::read_table2",   "data.io::hread_text",
    NA,
    "csv.gz",  "readr::read_csv",      "data.io::hread_text",
    "readr::write_csv",
    "csv2.gz", "readr::read_csv2",     "data.io::hread_text",
    NA,
    "tsv.gz",  "readr::read_tsv",      "data.io::hread_text",
    "readr::write_tsv",
    "txt.gz",  "readr::read_file",     NA,
    "readr::write_file",
    "csv.bz2", "readr::read_csv",      "data.io::hread_text",
    "readr::write_csv",
    "csv2.bz2","readr::read_csv2",     "data.io::hread_text",
    NA,
    "tsv.bz2", "readr::read_tsv",      "data.io::hread_text",
    "readr::write_tsv",
    "txt.bz2", "readr::read_file",     "data.io::hread_text",
    "readr::write_file",
    "csv.xz",  "readr::read_csv",      "data.io::hread_text",
    "readr::write_csv",
    "csv2.xz", "readr::read_csv2",     "data.io::hread_text",
    NA,
    "tsv.xz",  "readr::read_tsv",      "data.io::hread_text",
    "readr::write_tsv",
    "txt.xz",  "readr::read_file",     NA,
    "readr::write_file",
    # Buggy right now!! "csvy",    "csvy::read_csvy",    NA, "csvy::write_csvy",
    "xls",     "readxl::read_excel",   "data.io::hread_xls",
    "WriteXLS::WriteXLS",
    "xlsx",    "readxl::read_excel",   "data.io::hread_xlsx",
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
    "haven::write_xpt"   #,
    #"feather", "feather::read_feather",NA,
    #"feather::write_feather"
  ))

  if (!missing(new_type)) {
    # Check it is in a correct format
    if (!is.data.frame(new_type))
      stop("new_type must be a data.frame")
    if (ncol(new_type) != 4)
      stop("new_type must contain 4 columns",
        " (type, read_fun, read_header & write_fun")
    names(new_type) <- names(opts)
    opts <- rbind(opts, new_type)
  }

  options(read_write = opts)
  invisible(opts)
}

# TODO: check foreign fst, data.table, import and rio
# TODO: there is a xlsx writer in writexl, but does not support sheets!
# Note: csvy is csv with YAML header. It offers more configuration
#.import.rio_png <- function(file, native = FALSE, info = FALSE, ...) {
#  readPNG(file, native = native, info = info)
#}
