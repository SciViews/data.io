#' Read data in \R in different formats
#'
#' @param file The path to the file to read, or the name of the dataset to get
#'   from an \R package (in that case, you **must** provide the `package=`
#'   argument).
#' @param type The type (format) of data to read.
#' @param header The character to use for the header and other comments.
#' @param header.max The maximum of lines to consider for the header.
#' @param skip The number of lines to skip at the beginning of the file.
#' @param locale A readr locale object with all the data regarding required to
#' correctly interpret country-related items. The default value matches R
#' defaults as US English + UTF-8 encoding, and it is advised to be used as
#' much as possible.
#' @param lang The language to use (mainly for comment, label and units), but
#'   also for factor levels or other character strings if a translation exists
#'   and if the language is spelled with uppercase characters (e.g., `"FR"`).
#'   The default value can be set with, e.g., `options(data.io_lang = "fr")` for
#'   French.
#' @param lang_encoding Encoding used by R scripts for translation. They should
#' all be encoded as `UTF-8`, which is the default. However, this argument
#' allows to specify a different encoding if needed.
#' @param as_dataframe Deprecated: now use `options(SciViews.as_dtx = as_XXX)`
#'   to specify if you want a data.frame (`as_dtf`), a data.table (`as_dtt`, by
#'   default), or a tibble (`as_dtbl`).  Do we try to convert the resulting
#'   object into a `dataframe` (inheriting from `data.frame`, `tbl` and `tbl_db`
#'   alias `tibble`)? If `FALSE`, no conversion is attempted. Note that now,
#'   whatever you indicate, it is always assumed to be `FALSE` as part of the
#'   deprecation!
#' @param as_labelled Are variable converted into 'labelled' objects. This
#' allows to keep labels and units when the vector is manipulated, but it can
#' lead to incompatibilities with some R code (hence, it is `FALSE` by default).
#' @param comments Comments to add in the created object.
#' @param package The package where to look for the dataset. If `file=` is not
#'   provided, a list of available datasets in the package is displayed.
#' @param sidecar_file If `TRUE` and a file with same name as `file=` + `.R` is
#'   found in the same directory, it is considered as code to import these data
#'   and it is sourced with `local = TRUE`, `chdir = TRUE` and
#'   `verbose = FALSE`. That script **must** create an object named `dataset`,
#'   which is the result that is returned by the function. It is advised to
#'   encode this script in `UTF-8`, which is the default value, but it is
#'   possible to specify a different encoding through the `lang_encoding=`
#'   parameter.
#' @param hfun The function to read the header (lines starting with a special
#'   mark, usually '#' at the beginning of the file). This function must have
#'   the same arguments as `hread_text()` and should return a character string
#'   with the first `header.max` lines.
#' @param fun The function to delegate reading of the data. If `NULL` (default),
#'   The function is chosen from `fun_list`.
#' @param fun_list The table with correspondence of the types, read, and write
#'   functions.
#' @param data A synonym to `file=` (the name makes more sense when the dataset
#'   is loaded from a package). You cannot use `data=` and `file=` at the same
#'   time.
#' @param cache_file The path to a local file to use as a cache when file is
#'   downloaded (http://, https://, ftp://, or file:// protocols). If cache_file
#'   already exists, data are read from this cache, except if `force = TRUE`,
#'   see here under. Otherwise, data are saved in it before being used. If
#'   `cache_file = NULL` (the default), a temporary file is used and data are
#'   read from the Internet every time. This cache mechanism is particularly
#'   useful to provide data associated with a git repository. Put cache_file in
#'   `.gitignore` and use `cache_file=` in the code (and `force = FALSE`). That
#'   way, the data are downloaded once in a freshly cloned repository, and they
#'   are not included in the versioning system (useful for large datasets).
#' @param method The downloading method used (`"auto"` by default), see
#'   [utils::download.file()].
#' @param quiet In case we have to download files, do it silently (`TRUE`) or
#'   do we provide feedback and a progression bar (`FALSE`, by default)?
#' @param force If `TRUE` and an URL is provided for `file=` and a path for
#'   `cache_file=`, then the content is downloaded all the time, even if the
#'   cache file already exists (it overwrites it). By default, it is `FALSE`,
#'   which is the most useful setting to make good use of the cache mechanism.
#' @param full Do we return the full extension, like `csv.tar.gz` (`TRUE`), or
#'   only the main extension, like `csv` (`FALSE`, by default).
#' @param ... Further arguments passed to the function `fun=`.
#' @param x An object.
#' @param pattern A regular expression to list matching names.
#'
#' @description Read and return an \R object from data on disk, from URL, or
#' from packages.
#'
#' @return An \R object with the data (its class depends on the data being read).
#' @details `read()` allows for a unique entry point to read various kinds of
#' data, but it delegates the actual work to various other functions dispatched
#' across several \R packages. See `getOption("read_write")`.
#' @author Philippe Grosjean <phgrosjean@sciviews.org>
#' @export
#' @seealso [data_types()], [write()], [read_csv()]
#' @keywords utilities
#' @concept read and import data
#' @examples
#' # Use of read() as a more flexible substitute to data() (can change dataset
#' # name and syntax more similar to read R datasets and datasets from files)
#' read() # List all available datasets in your installed version of R
#' # List datasets in one particular package
#' read(package = "data.io")
#'
#' # Read one dataset from this package, possibly changing its name
#' (urchin <- read("urchin_bio", package = "data.io"))
#' # Same, but using labels in French
#' (urchin <- read("urchin_bio", package = "data.io", lang = "fr"))
#' # ... and also the levels of factors in French (note: uppercase FR)
#' (urchin <- read("urchin_bio", package = "data.io", lang = "FR"))
#'
#' # Read one dataset from another package, but with labels and comments
#' data(iris) # The R way: you got the initial datasets
#' # Same result, using read()
#' ir2 <- read("iris", package = "datasets", lang = NULL)
#' # ir2 records that it comes from datasets::iris
#' attr(comment(ir2), "src")
#' # otherwise, it is identical to iris, except is may be a data.table or a
#' # tibble, depending on user preferences
#' comment(ir2) <- NULL
#' # Force coercion into a data.frame
#' ir2 <- svBase::as_dtf(ir2)
#' identical(iris, ir2)
#' # More interesting: you can get an enhanced version of iris with read():
#' # (note that variable names ar in snake-case now!)
#' (ir3 <- read("iris", package = "datasets"))
#' class(ir3)
#' comment(ir3)
#' ir3$sepal_length
#' # ... and you can get it in French too!
#' (ir_fr <- read("iris", package = "datasets", lang = "fr"))
#' class(ir_fr)
#' comment(ir_fr)
#' ir_fr$sepal_length
#'
#' # Sometimes, datasets are more deeply reworked. For instance, trees has
#' # variables in imperial units (in, ft, and cubic ft), but it is automatically
#' # reworked by read() into metric variables (m or m^3):
#' data(trees)
#' head(trees)
#' (trees2 <- read("trees", package = "datasets"))
#' comment(trees2)
#' trees2$volume
#' \donttest{
#' # Read from a Github Gist (need to specify the type here!)
#' # (ble <- read$csv("http://tinyurl.com/Biostat-Ble"))
#'
#' # Various versions of the famous iris dataset
#' (iris <- read(data_example("iris.csv")))
#' (iris <- read(data_example("iris.csv.zip")))
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
#' #(iris <- read(data_example("iris.feather"))) # Not available for all Win
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
#'
#' # Note that where completion is available, you have a completion list of file
#' # format after typing read$<tab>
#' }
read <- structure(function(file, type = NULL, header = "#", header.max = 50L,
skip = 0L, locale = default_locale(), lang = getOption("data.io_lang", "en"),
lang_encoding = "UTF-8", as_dataframe = FALSE, as_labelled = FALSE,
comments = NULL, package = NULL, sidecar_file = TRUE, fun_list = NULL,
hfun = NULL, fun = NULL, data, cache_file = NULL, method = "auto",
quiet = FALSE, force = FALSE, ...) {
  # Note: this generates a warning when we use read()... not very nice!
  # However, I leave this as a comment in the code for developers
  #deprecate_soft("1.4.0", "read(as_dataframe)",
  #  details = "Please, do not use as_dataframe= any more. Specify which data frame class you want by using options(SciViews.as_dtx = as_dtf|as_dtt|as_dtbl) for data.frame, data.table or tibble tbl_df, respectively (as_dtt by default).")
  as_dataframe <- FALSE # Assumed to be FALSE all the time for now!

  if (!missing(data)) {
    if (missing(file)) {
      file <- data
    } else {
      stop("you cannot provide 'data' and 'file' at the same time")
    }
  }

  # Should the file be downloaded from internet?
  if (!missing(file) && grepl("^(http|https|ftp|file)://", file)) {
    # Is cache file defined, or should we use a temporary file?
    if (is.null(cache_file)) {
      ext <- type_from_extension(file, full = TRUE)
      if (is.null(ext)) ext <- ""
      # Make sure temp dir exists
      tempdir(check = TRUE)
      cache_file <- tempfile(fileext = ext)
    }
    # If cache_file exists, but we have force = TRUE, delete it now.
    if (file.exists(cache_file) && isTRUE(force))
      unlink(cache_file)
    # If cache_file exists, do not redownload the data, just use it.
    if (file.exists(cache_file)) {
      message("Using cached date in ", cache_file, "...")
    } else {# Try downloading the file
      # Try downloading the file
      res <- try(download.file(file, destfile = cache_file, method = method,
        quiet = quiet), silent = TRUE)
      if (inherits(res, "try-error"))
        stop("Error while downloading the file from ", file, "\n", res)
    }

    # file is now cache_file for the rest of the procedure
    file <- cache_file
  }

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
  if (missing(file) && missing(data)) {
    if (missing(package)) {# No file/data or package provided: list all datasets
      return(utils::data())
    }
    file2 <- ""
  } else {
    file2 <- paste0(file, ".R")
  }
  if (isTRUE(sidecar_file) && file.exists(file2)) {
    # Use a fake dataset content: it is supposed to be modified by the script
    dataset <- NULL
    source(file2, local = TRUE, chdir = TRUE, verbose = FALSE,
      encoding = lang_encoding)
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
      if (missing(file) && missing(data)) {
        # List of datasets available in the package
        return(utils::data(package = package))
      }
      suppressWarnings(utils::data(list = file, package = package, ...,
        envir = environment()))
      # For datasets like palmerpenguins::penguins_raw, data() cannot
      # retrieve it, both penguins and penguins_raw are retrieved with
      # data(penguins), so, make an exception
      if (!exists(file, envir = environment(), inherits = FALSE) &&
          file == "penguins_raw")
          suppressWarnings(utils::data(list = "penguins",
            package = package, ..., envir = environment()))
      if (!exists(file, envir = environment(), inherits = FALSE))
        stop("dataset '", file, "' not found in package '", package, "'")
      res <- get(file, envir = environment(), inherits = FALSE)
      src <- paste(package, file, sep = "::")

      # Look for a translation function or script for this dataset
      # Note that, if language is not found, we also look for the default
      # 'en' version as a fallback
      if (!is.null(lang)) {
        trans_fun <- function(x, full_lang, main_lang) {
          envir <- parent.frame()
          fun <- get0(paste0(".", x, "_", full_lang), envir = envir)
          if (is.null(fun))
            fun <- get0(paste0(".", x, "_", main_lang), envir = envir)
          if (is.null(fun))
            fun <- get0(paste0(".", x, "_en"), envir = envir)
          fun
        }
        # Look for a function first (either using lang or main_lang)
        fun <- trans_fun(file, full_lang, main_lang)
        if (!is.null(fun)) {
          res <- fun(res, labels_only = labels_only, as_labelled = as_labelled)
        } else {# Look for a script either in original package or in data
          trans_script <- function(x, full_lang, main_lang, package) {
            script <- system.file("translation",
              paste0(x, "_", full_lang, ".R"), package = package)
            if (script == "")
              script <- system.file("translation",
                paste0(x, "_", main_lang, ".R"), package = package)
            if (script == "")
              script <- system.file("translation",
                paste0(x, "_en.R"), package = package)
            script
          }
          script <- trans_script(file, full_lang, main_lang, package)
          if (script == "")
            script <- trans_script(file, full_lang, main_lang, "data.io")
          if (script != "") {# Source it, then run the corresponding function
            source(script, local = TRUE, chdir = TRUE, verbose = FALSE,
              encoding = lang_encoding)
            if (!is.null(fun <- trans_fun(file, full_lang, main_lang)))
              res <- fun(res, labels_only = labels_only,
                as_labelled = as_labelled)
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

      # If header is not NULL and a hread_xxx() function is available,
      # read as many lines as there are starting with this string
      # and decrypt header data/metadata
      attribs <- NULL
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
        fun <- .get_function(fun_item$read_fun)

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
            if (!is.na(new_units)) {
              # This conflicts with units::`units<-` that defines a method for
              # numeric, so, I prefer to change the attribute directly
              #units(res[[i]]) <- new_units
              attr(res[[i]], "units") <- new_units
            }
          }
        }
      }
    }
  }

  # Record the comments, lang, lang_encoding and origin of the data
  cmt <- comment(res)
  cmt[] <- c(cmt, comments)
  if (is.null(cmt)) cmt2 <- "" else cmt2 <- cmt
  attr(cmt2, "lang") <- lang
  attr(cmt2, "lang_encoding") <- lang_encoding
  if (!is.null(srcfile)) {
    attr(cmt2, "srcfile") <- srcfile
    comment(res) <- cmt2
  } else if (!is.null(src)) {
    attr(cmt2, "src") <- src
    comment(res) <- cmt2
  } else {
    comment(res) <- cmt2
  }

  # as_dataframe is now always FALSE and this code is not run any more
  # (deprecated argument!)
  if (isTRUE(as_dataframe)) {# Try to convert the object into a dataframe
    conv <- try(as_dataframe(res), silent = TRUE)
    if (!inherits(conv, "try_error"))
      res <- conv
  }

  # If the returned object is a data.frame, data.table or tibble tbl_df,
  # convert it now into the user preferred class
  res <- default_dtx(res)

  res
}, class = c("function", "subsettable_type", "read_function_subset"))

#' @export
#' @rdname read
type_from_extension <- function(file, full = FALSE) {
  # TODO: special case for URLs with more arguments!

  if (isTRUE(full)) {
    substitution <- "\\1\\2\\3"
  } else {
    substitution <- "\\1" # Only first extension (no .xz or .tar.gz)
  }

  # For a (compressed) .tar archive
  if (grepl("\\.([A-Za-z0-9]+)\\.tar(\\.gz|\\.xz|\\.bz2|\\.zip)?$", file))
    return(sub("^.+\\.([A-Za-z0-9]+)(\\.tar)(\\.gz|\\.xz|\\.bz2|\\.zip)?$",
      substitution, file))

  # For a compressed file
  if (grepl("\\.([A-Za-z0-9]+)(\\.gz|\\.xz|\\.bz2|\\.zip)$", file))
    return(sub("^.+\\.([A-Za-z0-9]+)()(\\.gz|\\.xz|\\.bz2|\\.zip)$",
      substitution, file))

  # For a regular extension
  if (grepl("\\.([A-Za-z0-9]+)$", file))
    return(sub("^.+\\.([A-Za-z0-9]+)()()$",
      substitution, file))

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

#' @export
#' @rdname read
#' @method .DollarNames read_function_subset
.DollarNames.read_function_subset <- function(x, pattern = "") {
  dt <- data_types(types_only = FALSE, view = FALSE)
  types <- sort(dt$type[!is.na(dt$read_fun)])
  types[grepl(pattern, types)]
}
