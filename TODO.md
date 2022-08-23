# data.io To Do list

-   Implement `.DollarNames()` to get a list of `read()` and `write()` types available, with a mechanism to add more types from additional packages.

-   An easier form to indicate labels and units

-   Allow for data transformation and store info in a 'transfo' attribute. For instance, transforming "size [mm]" using `log1p()` with something like `transfo(data = df, logsize = log1p(size))` would produce a `transfo = "log1p"` attribute in `logsize`. And when label is used in plots, we would get "log(size [mm] + 1)". Also a `backtransfo()` function to back transform variables.

-   `dictionary()` function that constructs a data dictionnary for a labelled dataset (we probably need more attributes too). Would contain something like: name, label, units, transformation, type, dimensions, missing, examples, comment.

-   allow for using dtplyr too.

-   Use 'fst' package + 'vroom'.

-   Look for a support of 'datapackage.r'.

-   reimport `print.subsettable()` from 'svMisc'

-   Completion in R and RStudio for `read$` and `write$`.

-   label versus comment for a dataframe?

-   Rework and modularize the `read()` function.

-   `rio::characterize()` or `factorize()` for SPSS or SAS datasets + more 'rio'.

-   Add more recognized classes ('Date', 'time', etc.) for headers (+ abbrev?)

-   make `iris.csvy`, `iris.csvy.zip`, `iris.sas7bdat` and `iris.syd` working: add 'foreign' functions & 'csvy'.

-   Look at 'fst' package for ultra-fast csv read/write (+ 'data.table').

-   Functions to write headers too: `write()` -\> `read()` should restore same object!

-   Integrate 'units' with the 'quantities', 'convertr', 'prettyunits' and 'units' packages.

-   A smaller example for `read()`, and detail all the cases in a vignette instead.

-   More tests!

-   revdep, see for instance, <https://github.com/hadley/nycflights13>
