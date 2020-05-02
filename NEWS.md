# data.io 1.3.0

- `as.dataframe(table_object)` was broekn with 'tibble' 3.0.0. Now we use a different code to convert `table` objects into `tibble`/`dataframe`. 

- Rework of sources and 'pkgdown' web site added.

- A new argument `data=` synonym to `file=` is added. It makes more sense for datasets loaded from packages.

- First argument of `write()` is now named `data=` for coherence.

- For the `mauna_loa` dataset, calls to `tidyr::gather()` (deprecated) are replaced by `tidyr::pivot_longer()`.

# data.io 1.2.2

- The example `iris_sidecar.csv.R` wrongly referred to `data::read()` instead of `data.io::read()`.

# data.io 1.2.1

- The French translation for the trees dataset had no `as_labelled()` argument.

# data.io 1.2.0

- It is now possible to specify the default language to use for `read()` with the option `data.io-lang`.

- `lang` and `lang_encoding` are now recorded as attributes of the comment of the imported object.

# data.io 1.1.0

- A basic version of `write()` is now available.

- `data_types()` function added to easily get information about data types that can be used with `read()` or `write()`.

- Description added into `read_write` options.

# data.io 1.0.1

- Bug corrected: forgot to change `data` -> `data.io` in `read_write` options.

# data.io 1.0.0

First version of the package on Github.
