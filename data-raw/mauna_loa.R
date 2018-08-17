SciViews::R
library(data.io)
library(dplyr)
library(tidyr)
mauna_loa <- data.io::read(here::here("data-raw", "mauna_loa.xls"),
  sheet = "avg_temp",na = "-----", skip = 11L, header = NULL, lang = NULL,
  as_dataframe = FALSE) %>%
  select(c(1, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24)) %>%
  gather(month, avg_temp, -year) %>%
  arrange(year) %>%
  mutate(avg_temp = round((avg_temp - 32) / 1.8, 1))

mauna_loa$min_temp <- data.io::read(here::here("data-raw", "mauna_loa.xls"),
  sheet = "min_temp",na = "-----", skip = 11L, header = NULL, lang = NULL,
  as_dataframe = FALSE) %>%
  select(c(1, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24)) %>%
  gather(month, min_temp, -year) %>%
  arrange(year) %>%
  mutate(min_temp = round((min_temp - 32) / 1.8, 1)) %>%
  pull(min_temp)

mauna_loa$max_temp <- data.io::read(here::here("data-raw", "mauna_loa.xls"),
  sheet = "max_temp",na = "-----", skip = 11L, header = NULL, lang = NULL,
  as_dataframe = FALSE) %>%
  select(c(1, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24)) %>%
  gather(month, max_temp, -year) %>%
  arrange(year) %>%
  mutate(max_temp = round((max_temp - 32) / 1.8, 1)) %>%
  pull(max_temp)

mauna_loa$avg_co2 <- data.io::read(here::here("data-raw", "mauna_loa.xls"),
  sheet = "CO2",na = "-99.99", skip = 69L, header = NULL, lang = NULL,
  as_dataframe = FALSE) %>%
  mutate(avg_CO2 = round(avg_CO2, 1)) %>%
  pull(avg_CO2)

comment(mauna_loa) <- NULL

# Convert into a mts object
mauna_loa <- ts(select(mauna_loa, avg_temp:avg_co2),
  start = 1955, frequency = 12)

# To save a copy of these data in R format
#saveRDS(mauna_loa, file = here::here("data-raw", "mauna_loa.rds"))

# To include it as a dataset inside the package
#mauna_loa <- readRDS(here::here("data-raw", "mauna_loa.rds"))
devtools::use_data(mauna_loa, overwrite = TRUE)
