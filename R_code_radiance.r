## R code for radiance 
library(raster) 
# we are creating a 2x2 raster 
toy <- raster(ncol=2, nrow=2, xmn=1, xmx=2, ymn=1, ymx=2) 
# now we are putting some values in the raster toy 
values(toy) <- c(1.13,1.44,1.55,3.4)

plot(toy)
text(toy, digits=2) # only two numbers in the decimals 

toy2bits <- stretch(toy,minv=0,maxv=3) 
# to only use integer numbers we use the function 
storage.mode(toy2bits[]) = "integer"
plot(toy2bits)
text(toy2bits, digits=2)
# we changed the original, the lower the n of bits we use, the lower the difference between pixels 

# let's use 4 bits, 16 values possible
toy4bits <- stretch(toy,minv=0,maxv=15)
storage.mode(toy4bits[]) = "integer"
plot(toy4bits)
text(toy4bits, digits=2)
# now we have 0 for pixel with radiance = 1.13 2 fro the pixel = 1.44 and 1.55, and 14 for the pixel of radiance 3.4
# so increasing the amount of bits the pixels might appear more different to each other 

# now 8 bits, 256 potential values 
toy8bits <- stretch(toy,minv=0,maxv=255)
storage.mode(toy8bits[]) = "integer"
plot(toy8bits)
text(toy8bits, digits=2)
# now we see that the two similar ones differ more 

# let's plot them all together 
par(mfrow=c(1,4))
plot(toy)
text(toy, digits=2)
plot(toy2bits)
text(toy2bits, digits=2)
plot(toy4bits)
text(toy4bits, digits=2)
plot(toy8bits)
text(toy8bits, digits=2)

dev.off()

library(rasterdiv)
plot(copNDVI)

# by looking at the info of this image (we get them by running the name) we see that the range is from 0 to 255 which means it is using 8 bits 







