## R code to view biomass over the world and calculate changes in ecosystem functions
# energy
# chemical cycling
# proxies
install.packages("rasterdiv")
install.packages("rasterVis")
library(rasterdiv)
library(rasterVis) 

data(copNDVI) # A RasterLayer of the global average NDVI value per pixel 
plot(copNDVI)

#we need to reclassify the data by removing the data from 253:255 given the NA value, so we are removing water.
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
levelplot(copNDVI)

copNDVI10 <- aggregate(copNDVI, fact=10)
levelplot(copNDVI10)
# to make the map smoother, with lower resolution 

#10k pixels together, very coarse and low detail 
copNDVI100 <- aggregate(copNDVI, fact=100)
levelplot(copNDVI100)

# we are going to make a scenario not sustainable with life and to increase CC in the planet -> great impact 

setwd("/Users/giulia/lab")
defor1 <- brick("defor1_.jpg.png") # imports different layers at a time 
defor2 <- brick("defor2_.jpg.png")

# if you just put the name of the object in R it gives data about it 
# band1: NIR
# band2: red
# band3: green 
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin") # Red-Green-Blue plot of a multi-layered Raster object
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

#defor1_.1 etc are the names of the band, i can obtain them by running on R only the name of the object (ex. defor1)
dvi1 <- defor1$defor1_.jpg.1 - defor1$defor1_.jpg.2
dvi2 <- defor2$defor2_.jpg.1 - defor2$defor2_.jpg.2

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) 
par(mfrow=c(1,2))
plot(dvi1, col=cl)
plot(dvi2, col=cl)

#let's see the difference in the dvi between the first one and the second one 
difdvi <- dvi1 - dvi2
dev.off()
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difdvi, col=cld) 
# like this we can see where we have lost the forests. -> we see the loss of ecosystem functions (red parts = loss in biomass and related services)

#to make an histogram 
hist(difdvi) 

















