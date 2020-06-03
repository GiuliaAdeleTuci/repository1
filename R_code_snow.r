# R_code_snow.r
setwd("/Users/giulia/lab") 
library(raster)
library(ncdf4)

# let's import the image from copernicus (we previously dowloaded it from the website)
snowmay <- raster("c_gls_SCE_202005260000_NHEMI_VIIRS_V1.0.1.nc")
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100) 

plot(snowmay, col=cl) 

# to have info about the n of pixels
snowmay 

### how to import multiple data together form copernicus 
## slow manner, one by one using raster 
setwd("/Users/giulia/lab/snow") 
snow2000 <- raster("snow2000r.tif")
snow2005 <- raster("snow2005r.tif")
snow2010 <- raster("snow2010r.tif")
snow2015 <- raster("snow2015r.tif")
snow2020 <- raster("snow2010r.tif")

# then to plot we use par 
par(mfrow=c(2,3))
plot(snow2000, col=cl)
plot(snow2005, col=cl)
plot(snow2010, col=cl)
plot(snow2015, col=cl)
plot(snow2020, col=cl)

## fast way 
# function lapply -> applies a function considering a list of files/objects all together  
# first we have to make the list of files -> list.files, with a common pattern 
rlist <- list.files(pattern="snow")
rlist

import <- lapply(rlist, raster) 

# now that we have imported the files we can apply the stack to make a stack of several layers
snow.multitemp <- stack(import)
plot(snow.multitemp, col=cl)

# now we can make a prediction 
library(rgdal)

# define the extent
ext <- c(-180, 180, -90, 90)
extension <- crop(snow.multitemp, ext) # crop returns a geographic subset of an object
    
# make a time variable (to be used in regression)
time <- 1:nlayers(snow.multitemp)

# run the regression
fun <- function(x) {if (is.na(x[1])){ NA } else {lm(x ~ time)$coefficients[2] }} 
predicted.snow.2025 <- calc(extension, fun) 

predicted.snow.2025.norm <- predicted.snow.2025*255/53.90828

# we can also simply import the code with the source function 
source("prediction.r")


### lesson 2
# exercise: import all the snow cover images together
library(raster) 
rlist <- list.files(pattern="snow")
import <- lapply(rlist, raster) 
snow.multitemp <- stack(import)
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100)
plot(snow.multitemp, col=cl)

# let's import the prediction image from last lesson 
prediction <- raster("predicted.2025.norm.tif")
plot(prediction, col=cl)

# how to export the output, first you write the name of what you want to export, and then the name you want it saved with. 
writeRaster(prediction, "final.tif")
# this function creates the data, it's not only an image. it's the opposite of the raster function  

# or to have a pdf of the graph
final.stack <- stack(snow.multitemp, prediction)
# we are stacking all together, at the end we will have a stack of the snow.multitemp + the prediciton (6 images). 
plot(final.stack, col=cl)

# now we export this graph with all the plots 
pdf("my_final_graph.pdf") # this is the name 
plot(final.stack, col=cl) # this goes inside the pdf
dev.off()

png("my_final_graph.png") # this is the name 
plot(final.stack, col=cl) # this goes inside the pdf
dev.off()




 




