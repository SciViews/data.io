#' Write data from \R in files in different formats
#'
#' @param data An object to write in a file. The accepted class depends on what
#' the delegated function expects (in many cases, a `data.frame` or `tibble` is
#' just fine). If `type` is not provided, a `data.frame` is **not** suitable
#' because only an atomic vector can be provided. Give a `matrix` instead, if
#' you want to write tabular data, or provide `type = "txt"` for instance.
#' @param file The path to the file to write to. If `type` is not provide, a
#' connection, or a character string naming the file to write to. If `""``,
#' print to the standard output connection. If it is `"|cmd"`, the output is
#' piped to the command given by `cmd`.
#' @param ncolumns The number of columns to write the data in when `type` is
#' provided, this is by-passed.
#' @param append If `TRUE` and `type` is not provided, the `data` are appended
#' to the connection.
#' @param sep A string used to separate columns. Using `sep = "\t"` gives tab
#' delimited output; default is `" "` when `type` is not provide, or the default
#' provided by the delegated function if this parameter is present there.
#' @param type The type (format) of data to read.
#' @param fun_list The table with correspondance of the types, read, and write
#'   functions.
#' @param x Same as `data=`, for compatibility with `base::write()`. Please, do
#'   not use both `data=` and `x=` as the same time, or an error will be
#'   generated.
#' @param ... Further arguments passed to the write function, when `type` is
#' explicitly provided.
#'
#' @description Write \R data into a file, in different formats.
#'
#' @return `data` is returned invisibly (on the contrary to [base::write()]
#' which returns `NULL`).
#' @details This function is designed to be fully compatible with
#' [base::write()], while allowing to specify `type` also, and get a more
#' interesting behavior in this case. Hence, when `type` is **not** provided,
#' either with `write(type = ...)`, or `write$...()`, the default code is used
#' and a plain text file wit fields separated by spaces (be default) is written.
#' When type is provided, then the exportation is delegated to specific
#' functions (see [data_types()]) to write the data in different formats.
#' @author Philippe Grosjean <phgrosjean@sciviews.org>
#' @export
#' @seealso [data_types()], [read()], [write_csv()], [base::write()]
#' @keywords utilities
#' @concept write and export data
#' @examples
#' # Always specify type to delegate to more sophisticated functions
#' # (type = NULL explicitly indicated meaning: "guess from file extension")
#' urchin <- read("urchin_bio", package = "data.io")
#' write(urchin, "urchin_temporary.csv", type = NULL)
#' # To use a format more easily readable by Excel
#' write(urchin, "urchin_temporary.csv", type = "xlcsv")
#' # ... equivalently (and more compact)
#' write$xlcsv(urchin, "urchin_temporary.csv")
#' # Tidy up
#' unlink("urchin_temporary.csv")
#'
#' # Write in Excel format
#' write$xlsx(urchin, "urchin_temporary.xlsx")
#' # Tidy up
#' unlink("urchin_temporary.xlsx")
#'
#' # Use base::write() code to output atomic vectors (and matices) in text files
#' # when you don't specify type=
#' mat1 <- matrix(1:12, nrow = 4)
#' # To get a similar presentation in the file, you have to do:
#' write(t(mat1), "my_temporary_data.txt", ncolumns = 3)
#' file.show("my_temporary_data.txt")
#' # Tidy up
#' unlink("my_temporary_data.txt")
#' rm(mat1)
write <- structure(function(data, file = "data",
ncolumns = if (is.character(data)) 1 else 5, append = FALSE, sep = " ",
type = NULL, fun_list = NULL, x, ...) {
  if (missing(data)) {
    if (missing(x)) {
      stop("you must provide either 'data=' or 'x='")
    } else {
      data <- x
    }
  }

  # If type is missing, base::write() is used!
  if (missing(type)) {
    base::write(x = data, file = file, ncolumns = ncolumns, sep = sep)
    return(invisible(data))
  }

  # Get fun_list from options() (and possibly install it)
  if (is.null(fun_list))
    fun_list <- getOption("read_write")
  # If not installed yet, do it now!
  if (is.null(fun_list))
    fun_list <- read_write_option()

  if (is.null(type))
    type <- type_from_extension(file)
  if (is.null(type))
    stop("no type provided, and impossible to guess")
  if (!type %in% fun_list$type) {
    stop("type '", type, "' is unknown")
  } else fun_item <- fun_list[fun_list$type == type, ]

  fun_name <- fun_item$write_fun
  if (is.na(fun_name))
    stop("no write function is provided for this type")
  fun <- .get_function(fun_name)
  if (!missing(sep)) {
    res <- fun(data, file, sep = sep, ...)
  } else {
    res <- fun(data, file, ...)
  }
  invisible(data)
}, class = c("function", "subsettable_type"))
