SciViews::R
library(data)
urchin_bio <- data::read(here::here("raw", "urchin_bio.xls"))
urchin_bio$origin <- factor(urchin_bio$origin)
urchin_bio$maturity <- as.integer(urchin_bio$maturity)
urchin_bio$sex <- factor(urchin_bio$sex)
urchin_bio <- as_tibble(urchin_bio)
class(urchin_bio) <- c("dataframe", "tbl_df", "tbl", "data.frame")
levels(urchin_bio$origin) <- c("Farm", "Fishery")
levels(urchin_bio$sex) <- c("F", "M")
# TODO: set labels to en
saveRDS(urchin_bio, file = here::here("raw", "urchin_bio.rds"))

# To include it as a dataset inside the package
urchin_bio <- readRDS(here::here("raw", "urchin_bio.rds"))
devtools::use_data(urchin_bio)
