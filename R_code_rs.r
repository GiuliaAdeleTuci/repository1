# R code for remote sensing data 
# we downloaded the data 
# install library raster
install.packages("raster")
install.packages("RStoolbox")

# or
install.packages(c("raster","RStoolbox"))

 setwd("/Users/giulia/lab")
library(raster)

# we are going to import some images of satellite images of an area of Brasil + we assign a name 
p224r63_2011 <- brick("p224r63_2011_masked.grd")

plot(p224r63_2011) # we can see the plot of the different reflectance of bands, now we change the color ramp palette
cl <- colorRampPalette(c("black","grey","light grey"))(100)
plot(p224r63_2011, col=cl)

#bands of landsat
# B1: blue
# B2: green 
# B3: red
# B4: near infrared NIR

# let's plot these 4 bands separetely 
#multiframe of different plots all together -> function par
# and make a new col ramp palette, so see colors on R colors()
par(mfrow=c(2,2))
clb <- colorRampPalette(c("dark blue","blue","light blue"))(100)
#and plot $ is used to link symbols 
plot(p224r63_2011$B1_sre, col=clb)

#now the green band
clg <- colorRampPalette(c("dark green","green","light green"))(100)
plot(p224r63_2011$B2_sre, col=clg)

# now red
clr <- colorRampPalette(c("dark red","red","pink"))(100)
plot(p224r63_2011$B3_sre, col=clr)

# now NIR
cln <- colorRampPalette(c("red","orange","yellow"))(100)
plot(p224r63_2011$B4_sre, col=cln)

# let's change the par
par(mfrow=c(4,1)) # to have them all in a column

# let's close the image with 
dev.off()

# we are goin to mount the bands 
# plotRGB, with linear stretching, and associtaed the bands with the respective colors
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
# how we would see it with our eyes

# now we are making all the components shift and add first the NIR, remove the blue 
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
# like this we mounted the NIR on top of the red component of the RGB spectrum so all the areas reflecting in the NIR will apear red

# put the NIR on top of the green component of the RGB
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")

# now NIR in the blue component
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

########
setwd("/Users/giulia/lab")
#load the R data from last lesson function load
# we are using data from 1988 this time so make a multitemporal comparison 
library(raster)
p224r63_1988 <- brick("p224r63_1988_masked.grd")
plot(p224r63_1988)

# excersise: plot in visible RGB 321 both images
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
# we can see the two images together so we can appreciate the changes, however the vegatation is difficult to see the veg 
# show the same plot but with 432 RGBspace, to see the NIR 
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

# this function enhances the coulds and in general the noise (why the rivers are greenish), in 1988 the humidity was 
# higher becuase of the higher functioning of the forest, hence the disturbance. as a result is shows evaportaspiration 
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")

#we are going to use the vegetation index
dvi2011 <- (p224r63_2011$B4_sre - p224r63_2011$B3_sre)
cl <- colorRampPalette(c("purple", "light blue", "pink"))(100)
plot(dvi2011, col=cl)

# the dvi is not amogeneous, it is sensible to the amount of water as well 
# excersise: dvi for 1988
dvi1988 <- (p224r63_1988$B4_sre - p224r63_1988$B3_sre)
cl <- colorRampPalette(c("purple", "light blue", "pink"))(100)
plot(dvi1988, col=cl)
# the different is not too high 
# difference from one year to the other
diff <- dvi2011 - dvi1988
plot(diff)

# let's see the effect of changing the grain (dimension of the pixels) 
# aggregate function, aggreagtes pixels to make a coarser grain, fact is the factor that indicates the factor of increase of the pixels.
# this process is called resampling 
p224r63_2011res <- aggregate(p224r63_2011, fact=10)
p224r63_2011res100 <- aggregate(p224r63_2011, fact=100)
par(mfrow=c(3,1))

plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011res100, r=4, g=3, b=2, stretch="Lin")

# sometimes high detail is equal to high noise = sometimes it's better to have medium resolution 




