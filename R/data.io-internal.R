.onLoad <- function(libname, pkgname) {
  read_write_option()
}

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