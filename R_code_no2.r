## R code for NO2 monitoring 
# we placed the files in a folder so that we can import them all together

setwd("/Users/giulia/lab/no2") 

library(raster)

# we create a list of files 
rlist <- list.files(pattern="EN")
rlist

# now we apply the raster function to all the objects in the list at the same time
import <- lapply(rlist, raster) 

# we create a stack of all the rasters 
EN <- stack(import)
cl <- colorRampPalette(c('blue','green','red'))(100) 

# we then plot them 
plot(EN, col=cl)

# let's plot the first one and the last one only to see the difference, january and march
par(mfrow=c(1,2))
plot(EN$EN_0001, col=cl)
plot(EN$EN_0013,col=cl)

# we can also make a RGB space, putting the R = EN_0001, G=0007 and B=0013, so that if the levels in the beginning were higher we sill se it in red
# in green we see the middle level and in blue the lastest values (march)
# firts dev.off()
plotRGB(EN, r=1, g=7, B=13, stretch='lin') 

# let's make a difference map 
dif <- EN$EN_0013 - EN$EN_0001
cld <- colorRampPalette(c('blue', 'white', 'red'))(100)
plot(dif,col=cld)

# let's make a boxplot of the whole stack
boxplot(EN)

# there are a lot of outliers, let's remove them 
boxplot(EN, outline=F)

# let's move the boxplots horizontal 
boxplot(EN, outline=F, horizontal=T)

# let's add the axes to make it easier to read
boxplot(EN, outline=F, horizontal=T, axes=T)

# we can see that the first image is in the bottom 
# we see that there is a negative exponential decrease in terms of no2, the max values in decreasing 

# we can plot the data of the first image and the data from the last image, 
# if it decreased most of the points should be under the 1 to 1 line
plot(EN$EN_0001, EN$EN_0013) 

# to insert the 1 to 1 line, y=x 
abline(0,1, col='red')
# we see that most of the data are under the curve -> it decreased

setwd("/Users/giulia/lab/snow")
rlist <- list.files(pattern="snow20")
rlist

import <- lapply(rlist, raster)
snow.multitemp <- stack(import)

plot(snow.multitemp)

# let's make some differences 
plot(snow.multitemp$snow2010r, snow.multitemp$snow2020r)
abline(0,1, col='red')

plot(snow.multitemp$snow2000r, snow.multitemp$snow2020r)
abline(0,1, col='red')







