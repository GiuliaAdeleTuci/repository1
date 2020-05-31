### Point pattern analysis: Density Map

install.packages("spatstat")
library(spatstat)
attach(covid)
head(covid)

# let's give a name to what we are about to make -> covids. ppp is planet point pattern 
# then explain x and y variables and the range for the numbers with c
covids <- ppp(lon, lat, c(-180,180), c(-90,90))
# if i put ?ppp R will explain the function -> Creates an object of class "ppp" representing a point pattern dataset in the two-dimensional plane.

# density of the covids object that we created before
d <- density(covids)
# to show the map i use plot
plot(d)

# let's put the points inside this plot
points(covids)


### second lesson
setwd("/Users/giulia/lab")
load("lesson4R.RData") # i load the work previously done and saved
ls() # ls shows what data sets and functions a user has defined

# covids: point pattern
# d: density map
library(spatstat)

plot(d)
# now let's put the points of the covid on the plot 
points(covids)

# let's put the coast lines, upload as an external geographical file, we are going to use the vector: line 
# using the data: coastline from iol 
# we need rgdal to use vectors 
library(rgdal)

# now we can inport coastlines and assigne the function (ogr) to the object coastlines. we input vector lines (x0y0, x1y1 ...)
coastlines <- readOGR("ne_10m_coastline.shp")

# add = true so that it doesn't erease the previous data 
plot(coastlines, add=T)
# we are seing the density in the countries

# changing the aspect of the map:
# first we are changing the color palette, we are stating to the software what color scheme we are trying to use. c()
# we can add the argument of the number of colors from yellow to red -> 100 is the max 
cl <- colorRampPalette(c("yellow","orange","red"))(100)
# then we change the color in the plot 
plot(d, col=cl)
# then we add the points and the coastlines
points(covids)
plot(coastlines, add=T)

# excersise: new color ramp palette 
gt <- colorRampPalette(c("green","light green"," light blue","purple"))(100)
plot(d,col=gt, main="Densities of Covid19")
points(covids)
plot(coastlines, add=T)
# to add the title main=""

# number of colors 
cll <- colorRampPalette(c("light green"," light blue","violet"))(5)
plot(d,col=gt, main="Densities of Covid19")
points(covids)
plot(coastlines, add=T)

# to export the plot, in pdf 
pdf("covid_density.pdf")
cll <- colorRampPalette(c("light green"," light blue","violet"))(100)
plot(d,col=gt, main="Densities of Covid19")
points(covids)
plot(coastlines, add=T)
# in the end you should close the process, to do so dev.off
dev.off()

# another option -> image png
png("covid_density.png")
cll <- colorRampPalette(c("light green"," light blue","violet"))(100)
plot(d,col=gt, main="Densities of Covid19")
points(covids)
plot(coastlines, add=T)
# in the end you should close the process, to do so dev.off
dev.off()

# pdf is more precise 












