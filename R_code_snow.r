# R_code_snow.r
setwd("/Users/giulia/lab") 
library(raster)
library(ncdf4)

# let's import the image from copernicus 
snowmay <- raster("c_gls_SCE_202005260000_NHEMI_VIIRS_V1.0.1.nc")
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100) 

plot(snowmay, col=cl) 

#to have info about the n of pixels
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
# first me have to make the list of files -> list.files, with a common pattern 
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
extension <- crop(snow.multitemp, ext)
    
# make a time variable (to be used in regression)
time <- 1:nlayers(snow.multitemp)

# run the regression
fun <- function(x) {if (is.na(x[1])){ NA } else {lm(x ~ time)$coefficients[2] }} 
predicted.snow.2025 <- calc(extension, fun) 

predicted.snow.2025.norm <- predicted.snow.2025*255/53.90828

# we can also simply import the code with the source function 
source("prediction.r")









