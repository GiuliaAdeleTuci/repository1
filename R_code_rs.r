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
plotRGB(p224r63_201, r=3, g=2, b=1, stretch="Lin")
# how we would see it with our eyes

# now we are making all the components shift and add first the NIR, remove the blue 
plotRGB(p224r63_201, r=4, g=3, b=2, stretch="Lin")
# like this we mounted the NIR on top of the red component of the RGB spectrum so all the areas reflecting in the NIR will apear red

# put the NIR on top of the green component of the RGB
plotRGB(p224r63_201, r=3, g=4, b=2, stretch="Lin")

# now NIR in the blue component
plotRGB(p224r63_201, r=3, g=2, b=4, stretch="Lin")
