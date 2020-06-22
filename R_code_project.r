
## analysis on the land cover around the lake to see the type of environments and if there are changes through time 
setwd("/Users/giulia/pro/landcovercl")
library(raster)
library(RStoolbox)
lcover01 <- brick("LandCover2001.TIFF")
cl <- colorRampPalette(c("green","yellow","brown"))(100)
plot(lcover01, col=cl)

plot(lcover01, col=cl, main="Land Cover 2001")

pdf("land_cover_2001.pdf")
plot(lcover01, col=cl, main="Land Cover 2001")
dev.off()

# now for the 2011
lcover11 <- brick("LandCover2011")
plot(lcover01, col=cl, main="Land Cover 2011")

pdf("land_cover_2011.pdf")
plot(lcover01, col=cl, main="Land Cover 2011")
dev.off()

# together 
par(mfrow=c(1,2))
plot(lcover01, col=cl, main="Land Cover 2001")
plot(lcover01, col=cl, main="Land Cover 2011")

# let's import everything together 
rlist <- list.files(pattern="LandCover")
rlist

import <- lapply(rlist, raster) 

land.multitemp <- stack(import)
plot(land.multitemp, col=cl)

pdf("land_cover.pdf")
plot(land.multitemp, col=cl)
dev.off()

# now let's just plot the Aral sea area area
lcover1 <- brick("LandCover2001.TIFF")
lcover11 <- brick("LandCover2011")

ext <- c(57,61, 42,47)
Land_Cover_2001c <- crop(lcover1, ext)
Land_Cover_2011c <- crop(lcover11, ext)

par(mfrow=c(1,2))
plot(Land_Cover_2001c, col=cl, main"LandCover_2001")
plot(Land_Cover_2011c, col=cl, main"LandCover_2011") 

pdf("land_cover_small.pdf")
par(mfrow=c(1,2))
plot(Land_Cover_2001c, col=cl, main="LandCover_2001")
plot(Land_Cover_2011c, col=cl, main="LandCover_2011") 
dev.off()

## Analysis of the satellite images of the Aral sea, from NASA website
## to see the trend of the dimentions of the lake during the past years 
setwd("/Users/giulia/pro/aral")
rlist <- list.files(pattern="aralsea")
rlist
import <- lapply(rlist, raster) 
Ar <- stack(import)
plot(Ar)
cl <- colorRampPalette(c("blue","yellow","brown"))(100)

pdf("aral.pdf")
plot(Ar, col=cl)
dev.off()

# now the difference 
dif <- Ar$aralsea_2000 - Ar$aralsea_2018

cld <- colorRampPalette(c('blue', 'white', 'red'))(100)
plot(dif,col=cld)

pdf("aral_dif.pdf")
plot(dif, col=cld, main="Difference 2000-2018")
dev.off()

# other analyses to see the variation in the dimensions in a more statistical way 
# the boxplot 
boxplot(Ar, outline=F, horizontal=T, axes=T, main="Boxplot_Variation_2000-2018")
pdf("aralboxplot.pdf")
boxplot(Ar, outline=F, horizontal=T, axes=T, main="Boxplot_Variation_2000-2018")
dev.off()

# plot of the variation 
plot(Ar$aralsea_2000, Ar$aralsea_2018) 
abline(0,1, col='red')

pdf("aral_plot.pdf")
plot(Ar$aralsea_2000, Ar$aralsea_2018, main="Plot_Variation_Area", pch=20, cex=0.3) 
abline(0,1, col='red')
dev.off()

## Analysis on lake salinity
setwd("/Users/giulia/pro/salt")
sal <- read.table("sal.csv", head=T, sep=",")
attach(sal) 
scatter.smooth(x=years,y=salinity, cex=0.6, col="red", xlab="years", ylab="Salinity - g/l", main="Salinity of Aral sea 1950-2000")

# save
pdf("Lakesalt.pdf")
scatter.smooth(x=years,y=salinity, cex=0.6, col="red", xlab="years", ylab="Salinity - g/l", main="Salinity of Aral sea 1950-2000")
dev.off()

## ndvi, to see if the vegetation is present and healthy 
setwd("/Users/giulia/pro/ndvi")
ndvi2000 <- brick("NDVI2020.TIFF")
ndvi2020 <- brick("NDVI2000")
ext <- c(57,61, 42,47)
ndvicrop00 <- crop(ndvi2000, ext)
ndvicrop20 <- crop(ndvi2020, ext)

par(mfrow=c(1,2))
cl <- colorRampPalette(c('darkblue','light blue','white'))(100)
plot(ndvicrop00, col=cl, main="NDVI_2000")
plot(ndvicrop20, col=cl, main="NDVI_2020")

pdf("NDVI.pdf")
par(mfrow=c(1,2))
plot(ndvicrop00, col=cl, main="NDVI_2000")
plot(ndvicrop20, col=cl, main="NDVI_2020")
dev.off()

dif <- ndvicrop00 - ndvicrop20 
cld <- colorRampPalette(c('yellow','orange','red'))(100)

# i'm saving with png because the pdf format is out of focus and i cannot appreciate the differences 
png("NDVI_diff.png")
plot(dif, col=cld, main="Difference_2000-2020_NDVI")
dev.off()

png("NDVI.png")
par(mfrow=c(1,2))
plot(ndvicrop00, col=cl, main="NDVI_2000")
plot(ndvicrop20, col=cl, main="NDVI_2020")
dev.off()











