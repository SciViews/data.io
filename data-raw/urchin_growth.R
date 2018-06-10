SciViews::R
library(data)
urchin_growth <- data::read(here::here("data-raw", "urchin_growth.xls"),
  lang = NULL, as_dataframe = FALSE)
urchin_growth$date <- as.Date(urchin_growth$date)
comment(urchin_growth) <- NULL
urchin_growth <- as.data.frame(urchin_growth)
# To save a copy of these data in R format
#saveRDS(urchin_growth, here::here("data-raw", "urchin_growth.rds"))

# To include it as a dataset inside the package
#urchin_growth <- readRDS(here::here("data-raw", "urchin_growth.rds"))
devtools::use_data(urchin_growth, overwrite = TRUE)
