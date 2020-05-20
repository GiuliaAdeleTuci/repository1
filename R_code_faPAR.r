# how to look at chemical cycling from satellites 

library(raster)
library(rasterVis)
library(rasterdiv)

# we are going to use again the copNDVI 
plot(copNDVI)

# we are removing the data from 253 to 255 and putting no value in its place, so we are removing water. 
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))

levelplot(copNDVI) # it shows also the graph of the variation of the NDVI in the different areas  
# forests that are not much structured in 3D so with similar individuals (fagus, conifers...) have very high biomass but low biodiversity

setwd("/Users/giulia/lab")

# let's import this data, 10 is becuase it is aggregated with a factor 10 
faPAR10 <- raster("faPAR10.tiff")
levelplot(faPAR10)

# we see a difference from the previous graph -> we had high NDVI in the equator and also in the forest in the north (the ones with the structure we said before)
# instead now the huge amount of photosynthesis is in the equator since in this area all the light is used by plants (fro the 3D structure) while in the northern forests the values are smaller. 
# in those forests with low 3D structure some part of the light is not used and goes into the soil. 

# to save images as pdf 
pdf("copNDVI.pdf")
levelplot(copNDVI)
dev.off

pdf("faPAR.pdf")
levelplot(faPAR10)
dev.off

########## day 2 
load("faPAR.Rdata")
# the original faPAR from copernicus is 2GB
# faPAR10 has data from values: 0, 0.9400001  (min, max), several pixels,very heavy 
# let's see the space needed for the copNDVI, 8 bit set 
library(raster)
library(rasterdiv)
writeRaster(copNDVI, "copNDVI.tif")
# only 5.5 MB -> better to use this one 

# let's make a levelplot of the faPAR
levelplot(faPAR10)


######## day 3 
# linear model between faPAR and NDVI, regression model
erosion <- c(12, 14, 16, 24, 26, 40, 55, 67)
hm <- c(30, 100, 150, 200, 260, 340, 460, 600)
plot(erosion, hm, col="red", pch=19, xlab="erosion", ylab="heavy metals", cex=2)

# let's make a linear model to see if they are related to eachother, we're extimating the slope and the intercept 
model1 <- lm(hm ~ erosion)
summary(model1) # to see the information of the model
abline(model1) # to make the regressione line in the graph 

# let's do the same for the faPar and NDVI 
setwd("/Users/giulia/lab")
library(raster)
library(rasterdiv)
faPAR10 <- raster("faPAR10.tiff")
plot(copNDVI)

# let's remove the water values from the copNDVI
copNDVI <- reclassify(copNDVI, cbind(253:255, NA), right=TRUE)

# now we have two variables (faPAR and copNDVI) and we want to see if they are related
# first we want to see the amount of cells in each raster, we see that the faPAR10 has a lot of cells so we want to use only a sample 
library(sf) # to call st_* functions
random.points <- function(x,n)
{
lin <- rasterToContour(is.na(x))
pol <- as(st_union(st_polygonize(st_as_sf(lin))), 'Spatial') # st_union to dissolve geometries
}
pts <- random.points(faPAR10,1000)
# now we have the random points that we will use (1k) 

copNDVIp <- extract(copNDVI,pts) # to extract data from the image into a table
faPAR10p <- extract(faPAR10,pts)

plot(copNDVIp,faPAR10p)

model2 <- lm(faPAR10p~copNDVIp)
summary(model2)
# we see through the r squared and the p-value that the correlation is not random
plot(copNDVIp,faPAR10p,col="green")
abline(model1,col="red")
# we can see that the two values are quite related with some exceptions (like conifer forests with a lot of biomass and low photosynthesis)
























