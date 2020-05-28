# Credits for this script go to Floris Uithof Junior Developer at CIT Groningen

# Install necessary packages
install.packages("GADMTools")
install.packages('sf')
install.packages("rnaturalearth")
install.packages("rnaturalearthdata")
install.packages("ggplot2")
install.packages("dplyr")
install.packages("osmdata")
install.packages("ggmap")
install.packages("RColorBrewer")

# Load packages
library(GADMTools)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
library(ggplot2)
library(dplyr)
library(osmdata)
library(ggmap)
library(RColorBrewer)

# Clear workplace
rm(list=ls())

# Set your working directory
getwd()
setwd('C:/Users/fuith/Documents/Geodienst/BertusRFile/psycorona')

# Load in shapefile of provinces of the whole world
map <- st_read(file.choose()) # open the shp file provided by Floris

# Load specific data for the Netherlands, can be easily replaced for each country. The filter is used to remove Saba and Saint Eustatius
# Provinces <- map %>% filter(admin == 'Netherlands', type == 'Provincie')
Provinces <- map


# Load the (random) data points
data <- read.csv('C:/Users/fuith/Documents/Geodienst/BertusRFile/psycorona/TestCSV.csv', header = T)
data$X.1 <- NULL

# Create the proper data set
data <- st_as_sf(data, coords=c("X","Y"), crs=4326, remove=FALSE)  

# Plot the map of the Netherlands and the datapoints
plot(Provinces$geometry)
plot(data$geometry, col='red', pch=16, cex=0.4,add = T)

# Select the provinces with points in them
provincesWithPoints <- Provinces[data, ]

# Plot of the provinces with data points in them in green, while the others are plot in red for the contrast
plot(Provinces$geometry, col=alpha('red', 0.3))
plot(provincesWithPoints$geometry, col=alpha("green",0.3), add = T)

# Add the Province name to each of the data points
dataPerProvince <- st_join(data, Provinces['name'])

# Give columns more descriptive names
colnames(dataPerProvince)[3] <- 'id'
colnames(dataPerProvince)[4] <- 'province'

############# Make a choice here: either keep the data that is not in a province and tag it (first option), or directly remove it (second option)
# Filter out all points that are not in a province
dataPerProvince$province[is.na(dataPerProvince$province)] <- 'no province'

# Optional: directly remove these values (I removed the step where you do this in the aggregated data)
dataPerProvince<-dataPerProvince[!is.na(dataPerProvince$province),]

############ This code only works without 'no province' data
# Aggregate the data per province
aggregatedData <- aggregate(dataPerProvince$id, by=list(Province = dataPerProvince$province), FUN = length)

# Add the counts of the points to the country data to create complete dataset
for( i in 1:nrow(provincesWithPoints)){
  for (j in 1:nrow(aggregatedData)){
    if(provincesWithPoints$name[i] == aggregatedData$Province[j]){
      provincesWithPoints$number[i] = aggregatedData$x[j]
    }
  }
}

# Create map of of the points
ggplot() +
  geom_sf(data=Provinces$geometry) +
  geom_sf(data=provincesWithPoints, aes(fill=number), lwd=1, alpha=0.8)+ 
  scale_fill_gradientn("Number of points", colours = brewer.pal(5, 'YlOrRd'))+
  ggtitle("Number of participants in each province") + theme(plot.title = element_text(hjust = 0.5))

# The map above serves as an example for how the data looks like and can of course be altered


##########################################Example for Germany #####################################################
# Load specific data for the Netherlands, can be easily replaced for each country. The filter is used to remove Saba and Saint Eustatius
Provinces <- map %>% filter(admin == 'Germany')

# Load the (random) data points
data <- read.csv('C:/Users/fuith/Documents/Geodienst/BertusRFile/psycorona/TestCSV.csv', header = T)
data$X.1 <- NULL

# Create the proper data set
data <- st_as_sf(data, coords=c("X","Y"), crs=4326, remove=FALSE)  

# Plot the map of the Netherlands and the datapoints
plot(Provinces$geometry)
plot(data$geometry, col='red', pch=16, cex=0.4,add = T)

# Select the provinces with points in them
provincesWithPoints <- Provinces[data, ]

# Plot of the provinces with data points in them in green, while the others are plot in red for the contrast
plot(Provinces$geometry, col=alpha('red', 0.3))
plot(provincesWithPoints$geometry, col=alpha("green",0.3), add = T)
#This example shows the use of the different colors

# Add the Province name to each of the data points
dataPerProvince <- st_join(data, Provinces['name'])

# Give columns more descriptive names
colnames(dataPerProvince)[3] <- 'id'
colnames(dataPerProvince)[4] <- 'province'

############# Make a choice here: either keep the data that is not in a province and tag it (first option), or directly remove it (second option)
# Filter out all points that are not in a province
dataPerProvince$province[is.na(dataPerProvince$province)] <- 'no province'

# Optional: directly remove these values (I removed the step where you do this in the aggregated data)
dataPerProvince<-dataPerProvince[!is.na(dataPerProvince$province),]

############ This code only works without 'no province' data
# Aggregate the data per province
aggregatedData<- aggregate(dataPerProvince$id, by=list(Province = dataPerProvince$province), FUN = length)
provincesWithPoints$number <- 0

# Add the counts of the points to the country data to create complete dataset
provincesWithPoints$name[2] == aggregatedData$Province[5]
for( i in 1:nrow(provincesWithPoints)){
  for (j in 1:nrow(aggregatedData)){
    if(provincesWithPoints$name[i] == aggregatedData$Province[j]){
      provincesWithPoints$number[i] = aggregatedData$x[j]
    }
  }
}

# Create map of of the points
ggplot() +
  geom_sf(data=Provinces$geometry) +
  geom_sf(data=provincesWithPoints, aes(fill=number), lwd=1, alpha=0.8)+ 
  scale_fill_gradientn("Number of points", colours = brewer.pal(5, 'YlOrRd'))+
  ggtitle("Number of participants in each province") + theme(plot.title = element_text(hjust = 0.5))
