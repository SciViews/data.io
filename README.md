# data - SciViews datasets and read()/write() functions

[![Linux & OSX Build Status](https://travis-ci.org/SciViews/data.svg )](https://travis-ci.org/SciViews/data)
[![Win Build Status](https://ci.appveyor.com/api/projects/status/github/SciViews/data?branch=master&svg=true)](http://ci.appveyor.com/project/phgrosjean/data)
[![Coverage Status](https://img.shields.io/codecov/c/github/SciViews/data/master.svg)
](https://codecov.io/github/SciViews/data?branch=master)
[![CRAN Status](http://www.r-pkg.org/badges/version/data)](http://cran.r-project.org/package=data)
[![License](https://img.shields.io/badge/license-GPL-blue.svg)](http://www.gnu.org/licenses/gpl-2.0.html)


## Installation

### Latest stable version

The latest stable version of **data** can simply be installed from [CRAN](http://cran.r-project.org):

```r
install.packages("data")
```


### Development version

Make sure you have the **devtools** R package installed:

```r
install.packages("devtools")
```

Use `install_github()` to install the **data** package from Github (source from **master** branch will be recompiled on your machine):

```r
devtools::install_github("SciViews/data")
```

R should install all required dependencies automatically, and then it should compile and install **data**.

Latest devel version of **data** (source + Windows binaires for the latest stable version of R at the time of compilation) is also available from [appveyor](https://ci.appveyor.com/project/phgrosjean/data/build/artifacts).


## Usage

Make the **data** package available in your R session:

```r
library("data")
```

Get help about this package:

```r
library(help = "data")
help("data-package")
```

For further instructions, please, refer to these help pages.


## Note to developers

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
