SciViews::R
library(data.io)
urchin_bio <- data.io::read(here::here("data-raw", "urchin_bio.xls"),
  lang = NULL, as_dataframe = FALSE)
urchin_bio$origin <- factor(urchin_bio$origin)
urchin_bio$maturity <- as.integer(urchin_bio$maturity)
urchin_bio$sex <- factor(urchin_bio$sex)
levels(urchin_bio$origin) <- c("Farm", "Fishery")
levels(urchin_bio$sex) <- c("F", "M")
comment(urchin_bio) <- NULL
urchin_bio <- as.data.frame(urchin_bio)
# To save a copy of these data in R format
#saveRDS(urchin_bio, file = here::here("data-raw", "urchin_bio.rds"))

# To include it as a dataset inside the package
#urchin_bio <- readRDS(here::here("data-raw", "urchin_bio.rds"))
devtools::use_data(urchin_bio, overwrite = TRUE)
