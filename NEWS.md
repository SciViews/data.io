# data.io 1.4.0

-   Dependency to {svBase} added. Now the `default_dtx()` function is used to output a data frame object in the user-preferred class (data.frame, data.table or tibble tbl_df) with `read()`.

-   The **dataframe** object class is deprecated. Consequently, `read()` does not output **dataframe** objects any more and `as_dataframe()` or `is_dataframe()` and similar functions are also deprecated. The `as_dataframe=` argument of `read()` is also deprecated now.

-   There is now a list completion for `read$<tab>` and `write$<tab>`.

-   The `read()` function can now download file (and sidecar file) directly for all types (previously, only for functions that accepted it internally, like `readr::read_csv()` but not for `readxl::read_xls()` for instance). The `cache_file=` argument allows to define a file to cache this download. If the file exists, the data are not redownloaded again. The `read()`function also tries to download a possible sidecar file from the URL + ".R" if `sidecar_file = TRUE`.

# data.io 1.3.1

-   Example using `.csv.tar` and `.csv.tar.gz` are eliminated because more recent `readr::read_csv()` function does not seem to handle Tar archives anymore (observed with {readr} version 2.1.2).

# data.io 1.3.0

-   `as.dataframe(table_object)` was broken with 'tibble' 3.0.0. Now we use a different code to convert `table` objects into `tibble`/`dataframe`.

-   Rework of sources and 'pkgdown' web site added.

-   A new argument `data=` synonym to `file=` is added. It makes more sense for datasets loaded from packages.

-   First argument of `write()` is now named `data=` for coherence.

-   For the `mauna_loa` dataset, calls to `tidyr::gather()` (deprecated) are replaced by `tidyr::pivot_longer()`.

# data.io 1.2.2

-   The example `iris_sidecar.csv.R` wrongly referred to `data::read()` instead of `data.io::read()`.

# data.io 1.2.1

-   The French translation for the trees dataset had no `as_labelled()` argument.

# data.io 1.2.0

-   It is now possible to specify the default language to use for `read()` with the option `data.io-lang`.

-   `lang` and `lang_encoding` are now recorded as attributes of the comment of the imported object.

# data.io 1.1.0

-   A basic version of `write()` is now available.

-   `data_types()` function added to easily get information about data types that can be used with `read()` or `write()`.

-   Description added into `read_write` options.

# data.io 1.0.1

-   Bug corrected: forgot to change `data` -\> `data.io` in `read_write` options.

# data.io 1.0.0

First version of the package on Github.
