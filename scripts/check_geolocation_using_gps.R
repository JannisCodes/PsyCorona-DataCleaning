library(readr)
library(renv)
library(countrycode)
library(revgeo)
# Set to NULL to get all GPS locations; takes a long time
number_of_gps <- 10

df_loc <- read.csv("data/raw data/RMS3_vanLissa_Cooperation 2020-04-19 12-42 CEST.csv", stringsAsFactors = F)

df_loc$countryiso3 <- countrycode::countrycode(df_loc$coded_country, origin = "country.name", destination = "iso3c")

df_loc$id <- paste0(formatC(df_loc$LocationLongitude, digits = 2, format = "f"), 
                    formatC(df_loc$LocationLatitude, digits = 2, format = "f"))

if(!file.exists(file.path("data", "cleaned data", "geolocate.csv", "id"))){
  gps <- df_loc[, c("LocationLongitude", "LocationLatitude")]
  gps$id <- paste0(formatC(gps$LocationLongitude, digits = 2, format = "f"), 
                   formatC(gps$LocationLatitude, digits = 2, format = "f"))
  gps <- gps[!duplicated(gps$id), ]
  if(is.null(number_of_gps)) number_of_gps <- nrow(gps)
  
  geolocs <- data.frame(revgeo(longitude=gps$LocationLongitude[1:number_of_gps], latitude=gps$LocationLatitude[1:number_of_gps], provider = 'photon', output="frame"), id = gps$id[1:number_of_gps], stringsAsFactors = FALSE)
  names(geolocs)[1:6] <- paste0("gps_", names(geolocs)[1:6])
  geolocs$gps_countryiso3 <- countrycode::countrycode(geolocs$gps_country, origin = "country.name", destination = "iso3c")
  write.csv(geolocs, file.path("data", "cleaned data", "geolocate.csv"), row.names = FALSE)
} else {
  geolocs <- read.csv(file.path("data", "cleaned data", "geolocate.csv"), stringsAsFactors = FALSE)
}

df_loc <- merge(df_loc, geolocs, all.x = TRUE, by = "id")

# Check which locations are mismatched
head(df_loc[which(df_loc$countryiso3 != df_loc$gps_countryiso3), ])
