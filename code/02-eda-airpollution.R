library(readr)
ozone <- read_csv("data/hourly_44201_2014.csv",col_types = "ccccinnccccccncnncccccc")
head(ozone)
