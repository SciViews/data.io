SciViews::R
library(data.io)
zooplankton <- readRDS(here::here("data-raw", "zooplankton.rds"))
attr(zooplankton, "traindir") <- NULL
attr(zooplankton, "path") <- NULL
rownames(zooplankton) <- NULL
zooplankton <- as.data.frame(zooplankton)
zooplankton <- zooplankton[, c("ECD", "Area", "Perim.", "Feret", "Major",
  "Minor", "Mean", "Mode", "Min", "Max", "StdDev", "Range", "MeanDia",
  "AspectRatio", "Elongation", "Compactness", "Transp1", "Circ.", "IntDen",
  "Class")]
names(zooplankton) <- c("ecd", "area", "perimeter", "feret", "major", "minor",
  "mean", "mode", "min", "max", "std_dev", "range", "size", "aspect",
  "elongation", "compactness", "transparency", "circularity", "density",
  "class")
# To save a copy of these data in R format
#saveRDS(urchin_bio, file = here::here("data-raw", "zooplankton2.rds"))

# To include it as a dataset inside the package
#zooplankton <- readRDS(here::here("data-raw", "zooplankton2.rds"))
devtools::use_data(zooplankton, overwrite = TRUE)
