SciViews::R
library(data)
urchin_growth <- data::read(here::here("data-raw", "urchin_growth.xls"))
urchin_growth$date <- as.Date(urchin_growth$date)
urchin_growth <- as_tibble(urchin_growth)
class(urchin_growth) <- c("dataframe", "tbl_df", "tbl", "data.frame")
# TODO: set labels to en
saveRDS(urchin_growth, here::here("data-raw", "urchin_growth.rds"))

# To include it as a dataset inside the package
urchin_growth <- readRDS(here::here("data-raw", "urchin_growth.rds"))
devtools::use_data(urchin_growth)