### diversity measurement
library(raster)
# now we import the image: raster which imports one single layer and brick which imports the whole image
snt <- brick("snt_r10.tif")
plot(snt)

#B1 is blue
#B2 green
#B3 red
#B4 NIR

plotRGB(snt, 3, 2, 1, stretch="Lin") # like this we plot is as the human eye would see it

plotRGB(snt, 4, 3, 2, stretch="Lin") #NIR on top of red, vegetation is then colored red

pairs(snt)

# for the PCA analysis 
library(RStoolbox)

sntpca <- rasterPCA(snt)
sntpca

summary(sntpca$model) # to have info, we see tht 70% of the info is carried by the first component -> good approximation 
plot(sntpca$map)

plotRGB(sntpca$map, 1,2,3, stretch="Lin")

# we're making use of the moving window on the PC1 to see the different sd
# set the moving window 5x5 pixels moving
window <- matrix(1, nrow = 5, ncol = 5)
window 

# now we apply the window (focal measurement), the functions that can be used are several, we are using the standard deviation 
sd_snt <- focal(sntpca$map$PC1, w=window, fun=sd)

cl <- colorRampPalette(c('dark blue','green','orange','red'))(100) 
plot(sd_snt, col=cl)
# we see low variability in the forest area and higher variability in the areas passing from forest to different ecosystems outside. 

# let's plot together the RGB plot and the one about variability 
par(mfrow=c(1,2))
plotRGB(snt, 4, 3, 2, stretch="Lin")
plot(sd_snt, col=cl)
# the second plot highlights the borders between environments, max variability 


