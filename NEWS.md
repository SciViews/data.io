# data.io 1.6.0

-   Now the default object returned by `read()` is a `data.trame` object.

-   The `read()` function now uses `data.table::fread()` and `data.table::fwrite()` for CSV and TSV files instead of the {readr} function. Consequently, {data.table} and {R.utils} (that {data.table} uses to read compressed CSV/TSV data) are now also imported. The previous `readr::read_csv()` and `readr::write_csv()` functions are now accessible with type `csv_alt`. Idem for types `csv2_alt` and `tsv_alt`.

# data.io 1.5.1

-   License changed to MIT for better and wider use.

# data.io 1.5.0

-   `.DollarNames()` implemented for `read()` and `write()` function, so that there is a completion list of the acceptable types.

-   `as_dataframe.dataframe()` and `as_dataframe.list()`, argument `validate=` is replaced by `.name.repair=` according to changes made in {tibble} 3.0 where the `validate=` argument is defunct now.

-   {palmerpenguins} `penguins` and `penguins_raw` data sets included (en and fr versions). The code of `read()` had to be patched because `data(penguins)` loads both `penguins` and `penguins_raw`, but `data(penguins_raw)` produces an error (sic!)

-   The {datasets} `ChickWeight`, `failthful`, `ToothGrowth` are now translated (en and fr versions).

-   The data sets `Penicillin` and `sleepstudy` from {lme4} are now translated (en and fr versions).

-   The data sets `babynames`, `applicants`, `births`, and `lifetables` from {babynames} are now translated (en and fr versions).

# data.io 1.4.1

-   There was a conflict in attributing units with the {units} package. So, when this package was loaded, `units(x) <- value` when `x` is numeric became a `units`object treated by {units}. We don't want this, so, the previous code is replaced by `attr(x, "units") <- value` to avoid this clash.

# data.io 1.4.0

-   Dependency to {svBase} added. Now the `default_dtx()` function is used to output a data frame object in the user-preferred class (data.frame, data.table or tibble tbl_df) with `read()`.

-   The **dataframe** object class is deprecated. Consequently, `read()` does not output **dataframe** objects any more and `as_dataframe()` or `is_dataframe()` and similar functions are also deprecated. The `as_dataframe=` argument of `read()` is also deprecated now.

-   There is now a list completion for `read$<tab>` and `write$<tab>`.

-   The `read()` function can now download a file directly for all types (previously, only for functions that accepted it internally, like `readr::read_csv()` but not for `readxl::read_xls()` for instance). The `cache_file=` argument allows to define a file to cache this download. If the file exists, the data are not redownloaded again, except if `force = TRUE`.

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
