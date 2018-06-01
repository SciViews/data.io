urchin_growth <- read_excel("~/Desktop/urchin_growth.xls")
urchin_growth$date <- as.Date(urchin_growth$date)
urchin_growth <- as_tibble(urchin_growth)
class(urchin_growth) <- c("dataframe", "tbl_df", "tbl", "data.frame")

# English translation:
urchin_growth$date <- set_label(urchin_growth$date, "Date")
urchin_growth$age <- set_label(urchin_growth$age, "Age", "years")
urchin_growth$diameter <- set_label(urchin_growth$diameter, "Test diameter", "mm")

# French translation:
urchin_growth$date <- set_label(urchin_growth$date, "Date")
urchin_growth$age <- set_label(urchin_growth$age, "Âge", "années")
urchin_growth$diameter <- set_label(urchin_growth$diameter, "Diamètre du test", "mm")

saveRDS(urchin_growth, file = "~/Desktop/urchin_growth.rds")
readRDS("~/Desktop/urchin_growth.rds")
# To include it as a dataset inside a package:
devtools::use_data(urchin_growth)
