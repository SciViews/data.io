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
#' @param lang The language to use (mainly for comment, label and units), but
#'   also for factor levels or other chanracter strings if a translation exists
#'   and if the language is spelled with uppercase characters (e.g., `"FR"`).
#' @param as_dataframe Do we try to convert the resulting object into a
#'   `dataframe` (inheriting from `data.frame`, `tbl` and `tbl_db` alias
#'   `tibble`)? If `FALSE`, no conversion is attempted.
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
#' # Read from a Github Gist (need to specify the type here!)
#' (ble <- read$csv("http://tinyurl.com/Biostat-Ble"))
#'
#' # Various versions of the famous iris dataset
#' (iris <- read(data_example("iris.csv")))
#' (iris <- read(data_example("iris.csv.zip")))
#' (iris <- read(data_example("iris.csv.tar"))) ##
#' (iris <- read(data_example("iris.csv.tar.gz"))) ##
#' (iris <- read(data_example("iris.csv.gz")))
#' (iris <- read(data_example("iris.csv.bz2")))
#' (iris <- read(data_example("iris.tsv")))
#' (iris <- read(data_example("iris.xls")))
#' (iris <- read(data_example("iris.xlsx")))
#' (iris <- read(data_example("iris.rds"))) # Does not tranform into tibble!
#' #(iris <- read(data_example("iris.syd"))) ##
#' #(iris <- read(data_example("iris.csvy"))) ##
#' #(iris <- read(data_example("iris.csvy.zip"))) ##
#'
#' # A file with an header both in English (default) and in French
#' (iris <- read(data_example("iris_short_header.csv")))
#' (iris_fr <- read(data_example("iris_short_header.csv"), lang = "fr"))
#' # Headers are also recognized in xls/xlsx files
#' (iris_fr <- read(data_example("iris_short_header.xls"), lang = "fr"))
#'
#' # Read a file with a sidecar file (same name + '.R')
#' (iris <- read(data_example("iris_sidecar.csv"))) # lang = "en" by default
#' (iris <- read(data_example("iris_sidecar.csv"), lang = "EN")) # Full lang
#' (iris <- read(data_example("iris_sidecar.csv"), lang = "en_us")) # US (in)
#' (iris <- read(data_example("iris_sidecar.csv"), lang = "fr")) # French
#' (iris <- read(data_example("iris_sidecar.csv"), lang = "FR_BE")) # Belgian
#' (iris <- read(data_example("iris_sidecar.csv"), lang = NULL)) # No labels
#'
#' # Require the feather package
#' #(iris <- read(data_example("iris.feather"))) # Not avaiable for all Win
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
skip = 0L, locale = default_locale(), lang = "en", as_dataframe = TRUE,
comments = NULL, package = NULL, sidecar_file = TRUE, fun_list = NULL,
hfun = NULL, fun = NULL, ...) {
  if (!is.null(lang)) {
    if (length(lang) != 1 || !is.character(lang))
      stop("lang must be a single character string or NULL")
    # If lang is provided in uppercase character, labels_only = FALSE
    labels_only <- (toupper(lang) != lang)
    full_lang <- tolower(lang) # Could be like 'en' or 'en_us'
    if (nchar(lang) < 2)
      stop("lang must be a single character vector like 'en', or 'en_US'")
    main_lang <- strsplit(lang, "_", fixed = TRUE)[[1]][1]
  } else {
    full_lang <- NULL
    main_lang <- NULL
    labels_only <- TRUE
  }
  type_provided <- !missing(type)
  srcfile <- NULL
  src <- NULL
  # Is there a sidecar file?
  if (missing(file)) {
    if (missing(package)) {# No file or package provided: list all datasets
      return(data())
    }
    file2 <- ""
  } else {
    file2 <- paste0(file, ".R")
  }
  if (isTRUE(sidecar_file) && file.exists(file2)) {
    # Use a fake dataset content: it is supposed to be modified by the script
    dataset <- NULL
    source(file2, local = TRUE, chdir = TRUE, verbose = FALSE,
      encoding = "UTF-8")
    if (is.null(dataset))
      stop("The script '", basename(file2),
        "' did not produce a valid 'dataset' object.",
        " Is it really a sidecar file?")
    res <- dataset
    srcfile <- file2

  } else {# No sidecar_file, read the data directly
    # Get fun_list from options() (and possibly install it)
    if (is.null(fun_list))
      fun_list <- getOption("read_write")
    # If not installed yet, do it now!
    if (is.null(fun_list))
      fun_list <- read_write_option()
    # If package is provided, get data from a package
    if (!is.null(package)) {
      if (missing(file)) {# List of datasets available in the package
        return(data(package = package))
      }
      suppressWarnings(data(list = file, package = package, ...,
        envir = environment()))
      if (!exists(file, envir = environment(), inherits = FALSE))
        stop("dataset '", file, "' not found in package '", package, "'")
      res <- get(file, envir = environment(), inherits = FALSE)
      src <- paste(package, file, sep = "::")

      # Look for a translation function or script for this dataset
      # Note thant, if language is not found, we also look for the default
      # 'en' version as a fallback
      if (!is.null(lang)) {
        trans_fun <- function(data, full_lang, main_lang) {
          envir <- parent.frame()
          fun <- get0(paste0(".", data, "_", full_lang), envir = envir)
          if (is.null(fun))
            fun <- get0(paste0(".", data, "_", main_lang), envir = envir)
          if (is.null(fun))
            fun <- get0(paste0(".", data, "_en"), envir = envir)
          fun
        }
        # Look for a function first (either using lang or main_lang)
        if (!is.null(fun <- trans_fun(file, full_lang, main_lang))) {
          res <- fun(res, labels_only = labels_only)
        } else {# Look for a script either in original package or in data
          trans_script <- function(data, full_lang, main_lang, package) {
            script <- system.file("translation",
              paste0(data, "_", full_lang, ".R"), package = package)
            if (script == "")
              script <- system.file("translation",
                paste0(data, "_", main_lang, ".R"), package = package)
            if (script == "")
              script <- system.file("translation",
                paste0(data, "_en.R"), package = package)
            script
          }
          script <- trans_script(file, full_lang, main_lang, package)
          if (script == "")
            script <- trans_script(file, full_lang, main_lang, "data")
          if (script != "") {# Source it, then run the corresponding function
            source(script, local = TRUE, chdir = TRUE, verbose = FALSE)
            if (!is.null(fun <- trans_fun(file, full_lang, main_lang)))
              res <- fun(res, labels_only = labels_only)
          }
        }
      }

    } else {# No package provided, read an external file

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

      get_function <- function(fun) {
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

      # If header is not NULL and a hread_xxx() function is available,
      # read as many lines as there are starting with this string
      # and decrypt header data/metadata
      attribs <- NULL
      if (is.null(hfun))
          hfun <- get_function(fun_item$read_header)
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
          if (dat[1L] == "---") {
            # TODO: how do we deal with yaml header?
            warning("YAML header not supported yet")
          } else {# A short form of header
            # If first line starts with a ., it is the type
            if (substring(dat[1L], 1L, 1L) == "." && !type_provided) {
              type <- substring(dat[1L], 2L)
              dat <- dat[-1L]
            }
            # There may be one line without key. It is comment: by default
            if (!grepl("^[A-Za-z][A-Za-z0-9_-]*:.+$", dat[1]))
              dat[1L] <- paste("comment:", dat[1])
            # Eliminate all lines not conforming with the key: value syntax
            dat <- dat[grepl("^[A-Za-z][A-Za-z0-9_-]*:.+$", dat)]
            # Now, split the strings into key - values
            keys <- sub("^ *([A-Za-z][A-Za-z0-9_-]*) *:.+$", "\\1", dat)
            # Cannot have duplicate items
            if (any(duplicated(keys)))
              stop("the header contains duplicated items")
            values <- sub("^ *[A-Za-z][A-Za-z0-9_-]* *: *(.+) *$", "\\1", dat)
            names(values) <- keys
            # Keep first default values for comment, labels, units & classes
            keep_keys <- c("comment", "labels", "units", "classes")
            attribs <- values[keep_keys]
            names(attribs) <- keep_keys
            if (!is.null(lang)) {
              # Substitute strings for main language
              keep_keys_main_lang <- paste(keep_keys, main_lang, sep = "_")
              attribs_main_lang <- values[keep_keys_main_lang]
              # Substitute non-NA values into attribs
              ok <- !is.na(attribs_main_lang)
              attribs[ok] <- attribs_main_lang[ok]
              if (full_lang != main_lang) {# Also substitute full lang (en_us)
                keep_keys_lang <- paste(keep_keys, full_lang, sep = "_")
                attribs_lang <- values[keep_keys_lang]
                # Substitute non-NA values into attribs
                ok <- !is.na(attribs_lang)
                attribs[ok] <- attribs_lang[ok]
              }
            }
            # comment is prepended to the comments variable
            com <- attribs["comment"]
            if (!is.na(com)) comments <- c(com, comments)
            # classes, labels and units will be used later on...
            attribs <- strsplit(attribs[2:4], ",", fixed = TRUE)
            attribs <- lapply(attribs, trimws)
            attribs <- lapply(attribs, function(x) {x[x == "NA"] <- NA; x})
            attribs <- try(data.frame(attribs, stringsAsFactors = FALSE),
              silent = TRUE)
            if (inherits(attribs, "try-error"))
              stop("labels, units, and classes do not have the same number",
                " of items in the header")
          }
        }
      } else n_header <- 0L

      # Do we have a function to read these data?
      if (is.null(fun))
        fun <- get_function(fun_item$read_fun)

      # Read the data
      skip_all <- skip + n_header
      if (skip_all > 0L) {
        res <- fun(file, skip = skip_all, ...)
      } else {
        res <- fun(file, ...)
      }
      srcfile <- file

      # Possibly process data in attribs
      if (!is.null(attribs)) {
        if (nrow(attribs) != ncol(res)) {
          warning("Not the right number of entries in labels, units & classes",
            " in the header (", nrow(attribs), ") but ", ncol(res), " needed.",
            " These attributes are ignored")
        } else {# Add label, units and class attributes
          for (i in 1:nrow(attribs)) {
            # Possibly change the class
            new_class <- attribs[i, "classes"]
            if (!is.na(new_class)) {
              # Are there arguments to the class? between ()
              if (grepl("^.+\\(.+\\)$", new_class)) {
                class_args <- sub("^.+\\((.+)\\)$", "\\1", new_class)
                class_args <- strsplit(class_args, "+", fixed = TRUE)[[1]]
                class_args <- trimws(class_args)
                class_args[class_args == "NA"] <- NA
                new_class <- sub("\\(.+$", "", new_class)
              } else class_args <- NULL
              res[[i]] <- switch(new_class,
                logical = as.logical(res[[i]]),
                integer = as.integer(res[[i]]),
                numeric = as.numeric(res[[i]]),
                character = as.character(res[[i]]),
                factor = if (is.null(class_args)) as.factor(res[[i]]) else
                  factor(res[[i]], levels = class_args),
                ordered = if (is.null(class_args)) as.ordered(res[[i]]) else
                  ordered(res[[i]], levels = class_args),
                warning("unknown class for variable ", i, ": ", new_class)
              )
            }

            # Possibly add a label
            new_label <- attribs[i, "labels"]
            if (!is.na(new_label))
              label(res[[i]]) <- new_label

            # Possibly add units
            new_units <- attribs[i, "units"]
            if (!is.na(new_units))
              units(res[[i]]) <- new_units
          }
        }
      }
    }
  }

  # Record the comments and origin of the data
  comments <- paste0(comments, collapse = "\n")
  if (!is.null(srcfile)) {
    attr(comments, "srcfile") <- srcfile
    comment(res) <- comments
  } else if (!is.null(src)) {
    attr(comments, "src") <- src
    comment(res) <- comments
  } else if (comments != "") {
    comment(res) <- comments
  }

  if (isTRUE(as_dataframe)) {# Try to convert the object into a dataframe
    conv <- try(as_dataframe(res), silent = TRUE)
    if (!inherits(conv, "try_error"))
      res <- conv
  }
  res
}, class = c("function", "subsettable_type"))

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
