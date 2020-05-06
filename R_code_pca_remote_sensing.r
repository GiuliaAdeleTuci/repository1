setwd("/Users/giulia/lab")

library(raster)
library(RStoolbox)

#now we use the function brick that is use to import the whole image of the satellite. 
p224r63_2011 <- brick("p224r63_2011_masked.grd")

#b1 blue
#b2 green
#b3 red
#b4 NIR
#b5 SWIR (short-wave infrared)
#b6 thermal infrared 
#b7 SWIR
#b8 panchromatic

# now we plot the image in the RGB space 
plotRGB(p224r63_2011, r=5, g=4, b=3, stretch="Lin")

#how to plot this data by ggplot2 
library(ggplot2)
ggRGB(p224r63_2011,5,4,3)
#similar image, different way of plotting

#let's do the same with the 1988 image 
p224r63_1988 <- brick("p224r63_1988_masked.grd")
plotRGB(p224r63_1988, r=5, g=4, b=3, stretch="Lin")

#now i put together the two images
par(mfrow=c(1,2))
plotRGB(p224r63_1988, r=5, g=4, b=3, stretch="Lin")
plotRGB(p224r63_2011, r=5, g=4, b=3, stretch="Lin")

# let's see if the bands are correlated to eachother 
# being correlated means that you are following the pattern of another variable, 
# we are going to see if band3 is correlated to band1 so if having small values of B1 is related to the values on B3 
# first we need to know the names of those bands 
names(p224r63_2011)
#"B1_sre" "B2_sre" "B3_sre" "B4_sre" "B5_sre" "B6_bt"  "B7_sre"

# $ link the bands to the image 
plot(p224r63_2011$B1_sre, p224r63_2011$B3_sre)
# we see very high correlation, we can then see the correlation coefficient R. 
# positive correlation: R=1, flat correlation: R=0, negative correlation: R=-1
# in this case it is very high 
# in this case 90% of the data is in the PC1 and only a small amount on th PC2 (proncipal component) 
# let's see this in R

# first we need to reduce the resolution, now there are too many pixels -> aggregate function, we are decreasing with a factor 10 
p224r63_2011_res <- aggregate(p224r63_2011, fact=10)

#library RStoolbox is needed
p224r63_2011_pca <- rasterPCA(p224r63_2011_res)

plot(p224r63_2011_pca$map)
# $ is liking all the different pieces of the output, call, model and map 

# let's change the color ramp 
cl <- colorRampPalette(c("dark grey","grey","light grey"))(100)
plot(p224r63_2011_pca$map, col=cl)

# we want to see the info about the model 
summary(p224r63_2011_pca$model)
# we can see that PC1 is accounting for 99.83% of the whole variation 

pairs(p224r63_2011)
# to see the amount of correlation between the different data 
# we see that the whole set is hugely correlated to eachother 

# now we can plot the first 3 compnents fro example 
plotRGB(p224r63_2011_pca$map, r=1, g=2, b=3, stretch="Lin")

# let's do the same for the 1988 
p224r63_1988_res <- aggregate(p224r63_1988, fact=10)
p224r63_1988_pca <- rasterPCA(p224r63_1988_res)
plot(p224r63_1988_pca$map, col=cl)
#here as well we can see that the PC1 has the highest amount of information
summary(p224r63_1988_pca$model) # -> we see that there is high correlation 
pairs(p224r63_1988)

# now we can make a difference between the 1988 and 2011 and then plotting the difference. 
# we are making the difference of every pixel
difpca <- p224r63_2011_pca$map - p224r63_1988_pca$map
plot(difpca)

# since the PC1 contains most of the information we can nly plot this one, only 1 layer
cldif <- colorRampPalette(c('blue','black','yellow'))(100)
plot(difpca$PC1, col=cldif)
# we see the areas that have changed most 
