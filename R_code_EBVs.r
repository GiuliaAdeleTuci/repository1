### diversity measurement
setwd("/Users/giulia/lab") 

library(raster)
# now we import the image: we can use raster which imports one single layer and brick which imports the whole image (different layers at a time)
snt <- brick("snt_r10.tif")
plot(snt)

# let's use plotRGB whici is used to plot the layers corresponding to the different color bands 
#B1 is blue
#B2 green
#B3 red
#B4 NIR

plotRGB(snt, 3, 2, 1, stretch="Lin") # like this we plot the image as the human eye would see it

plotRGB(snt, 4, 3, 2, stretch="Lin") #NIR on top of red, vegetation is then colored red

pairs(snt) # to produce a matrix of scatterplots 

# for the PCA analysis 
library(RStoolbox)

sntpca <- rasterPCA(snt)
sntpca

summary(sntpca$model) # to have info, we see tht 70% of the info is carried by the first component -> good approximation 
plot(sntpca$map)

plotRGB(sntpca$map, 1,2,3, stretch="Lin")

# we're making use of the moving window on the PC1 to see the different sd
# set the moving window of 5x5 pixels
window <- matrix(1, nrow = 5, ncol = 5)
window 

# now we apply the window (focal measurement) to the PC1, the functions that can be used are several, we are using the standard deviation 
sd_snt <- focal(sntpca$map$PC1, w=window, fun=sd)

cl <- colorRampPalette(c('dark blue','green','orange','red'))(100) 
plot(sd_snt, col=cl)
# we see low variability in the forest area and higher variability in the areas passing from forest to different ecosystems outside. 

# let's plot together the RGB plot and the one with the sd 
par(mfrow=c(1,2))
plotRGB(snt, 4, 3, 2, stretch="Lin")
plot(sd_snt, col=cl)
# the second plot highlights the borders between environments, max variability 

### lesson 2
# same analysis with a field image on lichens, cladonia 
setwd("/Users/giulia/lab")
library(raster) 
clad <- brick("cladonia_stellaris_calaita.JPG")
plotRGB(clad,1,2,3, stretch="lin")  

# we define the window 3x3 
window <- matrix(1, nrow = 3, ncol = 3)
window

# now we use the focal function 
# we will apply it to a specific band of the image, we will use the very first band 
pairs(clad) # to see how much they are correlated 

# we can also use the pca 
library(RStoolbox)
cladpca <- rasterPCA(clad) # this was we have the first component that expalins 99% of it

# we can use the cladpca to the the data which is the output of the function 
cladpca 

# let's see how much info is explained by the first pca 
summary(cladpca$map) 
# 98% is explained bu the first component 
plotRGB(cladpca$map, 1, 2, 3, stretch="lin")

# let's make the measurement of the cladonia through the moving window, to see the diversity 
sd_clad <- focal(cladpca$map$PC1, w=window, fun=sd)

PC1_agg <- aggregate(cladpca$map$PC1, fact=10) # we aggregate the image wit ha factor of 10 
sd_clad_agg <- focal(PC1_agg, w=window, fun=sd)

par(mfrow=c(1,2))
cl <- colorRampPalette(c('yellow', 'violet', 'black'))(100) 
plot(sd_clad, col=cl)
plot(sd_clad_agg, col=cl)

# the meaning: we see that all the microvariability in the strucutre of cladonia can be measured, it tells the complexity of the structure of the organism

plotRGB(clad, 1,2,3, stretch="lin")
plot(sd_clad_agg, col=cl)
 







