
# data.io

<!-- badges: start -->
[![Linux Build Status](https://travis-ci.com/SciViews/data.io.svg )](https://travis-ci.com/SciViews/data.io)
[![Win Build Status](https://ci.appveyor.com/api/projects/status/github/SciViews/data.io?branch=master&svg=true)](https://ci.appveyor.com/project/phgrosjean/data-io)
[![Coverage Status](https://img.shields.io/codecov/c/github/SciViews/data.io/master.svg)
](https://codecov.io/github/SciViews/data.io?branch=master)
[![CRAN Status](https://www.r-pkg.org/badges/version/data.io)](https://cran.r-project.org/package=data.io)
[![License](https://img.shields.io/badge/license-GPL-blue.svg)](https://www.gnu.org/licenses/gpl-2.0.html)
[![Life
cycle stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://www.tidyverse.org/lifecycle/#stable)
[![R-CMD-check](https://github.com/SciViews/data.io/workflows/R-CMD-check/badge.svg)](https://github.com/SciViews/data.io/actions)
<!-- badges: end -->

> 'data.io' main functions are `read()` and `write()`. They are made super-easy to import and export data in various formats in an unified way (they use functions from other packages under the hood like 'haven', 'readr', 'readxl', 'writexl', ...). They care about metadata, in particular, meaningful labels and units for the variables. Also, a mechanism to preprocess datasets using sidecar files, and to translate them into various languages are provided for a subset of R packages datasets.

## Installation

The latest stable version of 'data.io' can simply be installed from [CRAN](http://cran.r-project.org):

```r
install.packages("data.io")
```

You can also install the latest developement version. Make sure you have the 'devtools' R package installed:

```r
install.packages("devtools")
```

Use `install_github()` to install the 'data.io' package from Github (source from **master** branch will be recompiled on your machine):

```r
devtools::install_github("SciViews/data.io")
```

R should install all required dependencies automatically, and then it should compile and install 'data.io'.

Latest devel version of 'data.io' (source + Windows binaires for the latest stable version of R at the time of compilation) is also available from [appveyor](https://ci.appveyor.com/project/phgrosjean/data.io/build/artifacts).

## Further explore 'data.io'

You can get further help about this package this way: Make the 'data.io' package available in your R session:

```r
library("data.io")
```

Get help about this package:

```r
library(help = "data.io")
help("data.io-package")
vignette("data-io") # None is installed with install_github()
```

For further instructions, please, refer to these help pages at https://www.sciviews.org/data.io/.

## Code of Conduct

Please note that the **data.io** project is released with a [Contributor Code of Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html). By contributing to this project, you agree to abide by its terms.
