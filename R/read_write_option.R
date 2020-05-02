#' Define default read/write options and add items to it
#'
#' @param new_type A data.frame with four columns: `type`, `read_fun`,
#'   `read_header` and `write_fun` containing each a single character string or
#'   `NA`. `type` is the usual extension for this type of file, e.g., `png` for
#'   PNG images, `read_fun`, `read_header` and `write_fun` are character strings
#'   with "pkg::fun" format ("pkg" is the package containing the function and
#'   "fun" is the function name), or just "fun" if the function
#'   is visible on the search path.
#'
#' @description Define the functions that [read()] or write() must call to
#' import or export data for the different types (formats).
#'
#' @return The data.frame with all known formats is returned invisibly. The same
#' data.frame is also saved in the `read_write`` option, and can be retrieved
#' directly with `getOption("read_write")`.
#' @author Philippe Grosjean <phgrosjean@sciviews.org>
#' @export
#' @seealso [read()], [getOption()]
#' @keywords utilities
#' @concept labeling objects
#' @examples
#' # The default options
#' (read_write_option())
#' # To add a new type:
#' tail(read_write_option(data.frame(type = "png", read_fun = "png::readPNG",
#'   read_header = NA, write_fun = "png::writePNG", comment = "PNG image")))
read_write_option <- function(new_type) {
  opts <- getOption("read_write", default = tibble::tribble(
    ~type,     ~read_fun,              ~read_header,
    ~write_fun,               ~comment,
    "csv",     "readr::read_csv",      "data.io::hread_text",
    "readr::write_csv",       "comma separated values",
    "csv2",    "readr::read_csv2",     "data.io::hread_text",
    NA,                       "semicolon separated values",
    "xlcsv",   "readr::read_csv",      "data.io::hread_text",
    "readr::write_excel_csv",  "write a CSV file more easily readable by Excel",
    "tsv",     "readr::read_tsv",      "data.io::hread_text",
    "readr::write_tsv",        "tab separated values",
    "fwf",     "readr::read_fwf",      "data.io::hread_text",
    NA,                         "fixed width file", # TODO: a writer here!
    "log",     "readr::read_log",      NA,
    NA,                          "standard log file", # TODO: a writer here!
    "rds",     "readr::read_rds",      NA,
    "readr::write_rds",          "R data file (no compression by default)",
    "txt",     "readr::read_file",     NA,
    "readr::write_file",         "text file (as length 1 character vector)",
    "raw",     "readr::read_file_raw", NA,
    NA,                           "binary file (read as raw vector)",
                                                     # TODO: a writer here!
    "ssv",     "readr::read_table",    "data.io::hread_text",
    NA,                           "space separated values (strict)",
    "ssv2",    "readr::read_table2",   "data.io::hread_text",
    NA,                           "space separated values (relaxed)",
    "csv.gz",  "readr::read_csv",      "data.io::hread_text",
    "readr::write_csv",            "gz compressed comma separated values",
    "csv2.gz", "readr::read_csv2",     "data.io::hread_text",
    NA,                            "gz compressed semicolon separated values",
    "tsv.gz",  "readr::read_tsv",      "data.io::hread_text",
    "readr::write_tsv",             "gz compressed tab separated values",
    "txt.gz",  "readr::read_file",     NA,
    "readr::write_file",            "gz compressed text file",
    "csv.bz2", "readr::read_csv",      "data.io::hread_text",
    "readr::write_csv",             "bz2 compressed comma separated values",
    "csv2.bz2","readr::read_csv2",     "data.io::hread_text",
    NA,                             "bz2 compressed semicolon separated values",
    "tsv.bz2", "readr::read_tsv",      "data.io::hread_text",
    "readr::write_tsv",             "bz2 compressed tab separated values",
    "txt.bz2", "readr::read_file",     "data.io::hread_text",
    "readr::write_file",            "bz2 compressed text file",
    "csv.xz",  "readr::read_csv",      "data.io::hread_text",
    "readr::write_csv",             "xz compressed comma separated values",
    "csv2.xz", "readr::read_csv2",     "data.io::hread_text",
    NA,                             "xz compressed semicolon separated values",
    "tsv.xz",  "readr::read_tsv",      "data.io::hread_text",
    "readr::write_tsv",             "xz compressed tab separated values",
    "txt.xz",  "readr::read_file",     NA,
    "readr::write_file",            "xz compressed text file",
    # Buggy right now!! "csvy",    "csvy::read_csvy",    NA, "csvy::write_csvy",
    # "comma separated value with YAML header",
    "xls",     "readxl::read_excel",   "data.io::hread_xls",
    "WriteXLS::WriteXLS",            "Excel old .xls format",
    "xlsx",    "readxl::read_excel",   "data.io::hread_xlsx",
    "writexl::write_xlsx",    "Excel new .xlsx format", #"openxlsx::write.xlsx",
    "dta",     "haven::read_dta",      NA,
    "haven::write_dta",              "Stata DTA format",
    # read_dta() = read_stata()
    "sas",     "haven::read_sas",      NA,
    "haven::write_sas",               "SAS format",
    "sas7bdat","haven::read_sas",      NA,
    "haven::write_sas",                "SAS format (sas7bdat)",
    "sav",     "haven::read_sav",      NA,
    "haven::write_sav",                "SPSS .sav format",
    "zsav",    "haven::read_sav",      NA,
    "haven::write_sav",                "SPSS .zsav format",
    "por",     "haven::read_por",      NA,
    NA,                                "SPSS .por format",
    # read_por()/read_sav() = read_spss()
    "xpt",     "haven::read_xpt",      NA,
    "haven::write_xpt",                "SPSS transport format (FDA compliant)"#,
    #"feather", "feather::read_feather",NA,
    #"feather::write_feather",        "transportable feather format"
  ))

  if (!missing(new_type)) {
    # Check it is in a correct format
    if (!is.data.frame(new_type))
      stop("new_type must be a data.frame")
    if (ncol(new_type) != 5)
      stop("new_type must contain 5 columns",
        " (type, read_fun, read_header, write_fun & comment")
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
