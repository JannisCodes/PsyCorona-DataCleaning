library(gert)
library(countrycode)
source(file.path("scripts", "functions", "merge_metadata.R"))

metadata_location <- file.path("data", "metadata")
get_metadata(metadata_location, overwrite = FALSE)
# See which metadata files are available
which_files(metadata_location)

your_datafile <- read.csv(file.path("data", "raw data", "RMS3_vanLissa_Cooperation 2020-04-19 12-42 CEST.csv"), stringsAsFactors = F)
your_datafile$countryiso3 <- countrycode::countrycode(your_datafile$coded_country, origin = "country.name", destination = "iso3c")

merged_data <- merge_files(your_datafile, "CSSE", metadata_location)