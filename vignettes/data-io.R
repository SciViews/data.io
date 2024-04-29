## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
library(data.io)

## -----------------------------------------------------------------------------
library(data.io)
# Instead of data(iris), we use:
iris <- read("iris", package = "datasets")
head(iris)

## -----------------------------------------------------------------------------
str(iris)

## -----------------------------------------------------------------------------
comment(iris)

## -----------------------------------------------------------------------------
iris <- read("iris", package = "datasets", lang = "fr")
str(iris)

## -----------------------------------------------------------------------------
trees <- read("trees", package = "datasets")
head(trees)
str(trees)

## -----------------------------------------------------------------------------
data(trees)
head(trees)
str(trees)

## -----------------------------------------------------------------------------
data_example("iris.csv.gz")

## -----------------------------------------------------------------------------
read$csv.gz(data_example("iris.csv.gz")) # Type optional (explicit extension)

## -----------------------------------------------------------------------------
df <- data.frame(
  age = 1:10,
  size = 3 + 0.5 * (1:10) + rnorm(10),
  sex = sample(c("M", "F"), 10, replace = TRUE)
)
# Add labels and units
df <- labelise(df,
  label = list(age = "Age", size = "Body size", sex = "Sex"),
  units = list(age = "years", size = "cm"))
str(df)

## -----------------------------------------------------------------------------
(iris_sidecar_csv_file <- data_example("iris_sidecar.csv"))
data_example("iris_sidecar.csv.R")

## -----------------------------------------------------------------------------
# Without sidecar file
(iris_no_sc <- read$csv(iris_sidecar_csv_file, sidecar_file = FALSE))
str(iris_no_sc)

## -----------------------------------------------------------------------------
# With sidecar file (sidecar_file = TRUE is the default)
(iris_sc <- read$csv(iris_sidecar_csv_file))
str(iris_sc)

## ---- eval=FALSE--------------------------------------------------------------
#  (ble <- read$csv("http://tinyurl.com/Biostat-Ble"))

## ---- eval=FALSE--------------------------------------------------------------
#  # Here, we use the temporary directory for the example
#  # but you should use a permanent directory in your project
#  ble_cache_file <- file.path(tempdir(), "ble.csv")
#  (ble <- read$csv("http://tinyurl.com/Biostat-Ble",
#    cache_file = ble_cache_file))

## ---- eval=FALSE--------------------------------------------------------------
#  cat(readLines(ble_cache_file)[1:4], sep = "\n")

## ---- eval=FALSE--------------------------------------------------------------
#  ble <- read$csv("http://tinyurl.com/Biostat-Ble",
#    cache_file = ble_cache_file)

## ---- eval=FALSE--------------------------------------------------------------
#  ble <- read$csv("http://tinyurl.com/Biostat-Ble",
#    cache_file = ble_cache_file, force = TRUE)

## -----------------------------------------------------------------------------
data.io::data_types(view = FALSE)

