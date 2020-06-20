
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

# let's import them together 
rlist <- list.files(pattern="LandCover")
rlist

import <- lapply(rlist, raster) 

land.multitemp <- stack(import)
plot(land.multitemp, col=cl)

pdf("land_cover.pdf")
plot(land.multitemp, col=cl)
dev.off()

# now let's just plot the Aral sea area
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

# Analysis on lake water quality 
setwd("/Users/giulia/pro/lake")

rlist <- list.files(pattern="LWQ")
rlist

import <- lapply(rlist, raster) 

lwq.multitemp <- stack(import)

cl <- colorRampPalette(c("red","yellow","blue"))(100)
plot(lwq.multitemp, col=cl)

library(rgdal)

# define the extent
ext <- c(57,61, 42,47)
extension <- crop(lwq.multitemp, ext)
plot(extension)

# save 
cld <- colorRampPalette(c("blue","yellow","red"))(100)
pdf("Lakewq.pdf")
plot(extension, col=cld, main="Lake_Water_Quality 2016-2020")
dev.off()

## NDVI
setwd("/Users/giulia/pro/ndvi")

ndvi16 <- brick("NDVI300_2016.nc")
ndvi20 <- brick("NDVI300_2020.nc")

ndvicrop16 <- crop(ndvi16, ext)
ndvicrop20 <- crop(ndvi20, ext)

par(mfrow=c(1,2)) 
plotRGB(ndvi16, r=5, g=4, b=3, stretch="Lin") ## lentissimo rifare 
plotRGB(ndvi20, r=5, g=4, b=3, stretch="Lin")


## tentativo con immagini NASA 
ndvi2000 <- brick("NDVI2020.TIFF")
ndvi2020 <- brick("NDVI2000")

ext <- c(57,61, 42,47)
ndvicrop00 <- crop(ndvi2000, ext)
ndvicrop20 <- crop(ndvi2020, ext)

par(mfrow=c(1,2))
plotRGB(ndvicrop00, r=3, g=2, b=1, stretch="Lin")
plotRGB(ndvicrop20, r=3, g=2, b=1, stretch="Lin")


## 
ndvi00 <- brick("c_gls_NDVI_200001010000_GLOBE_VGT_V2.2.1.nc")
ndvi20 <- brick("c_gls_NDVI_202001010000_GLOBE_PROBAV_V2.2.1.nc")

ndvicrop00 <- crop(ndvi00, ext)
ndvicrop20 <- crop(ndvi20, ext)

par(mfrow=c(1,2)) 
plotRGB(ndvicrop00, r=5, g=4, b=3, stretch="Lin") 
plotRGB(ndvicrop20, r=5, g=4, b=3, stretch="Lin")

## proviamo a fare fapar invece
setwd("/Users/giulia/pro/fapar")
fapar10 <- raster("c_gls_FAPAR_201001240000_GLOBE_VGT_V1.4.1.nc")
fapar19 <- raster("c_gls_FAPAR_201901240000_GLOBE_PROBAV_V1.5.1.nc")

ext <- c(57,61, 42,47)
faparcrop10 <- crop(fapar10, ext)
faparcrop19 <- crop(fapar19, ext)

par(mfrow=c(1,2)) 
levelplot(faparcrop10)
levelplot(faparcrop19)
## FA CACARE NON VA BENE 








## con ndvi pensavo di fare che li plotto in rgb e poi con il ir sul rosso e poi vedo la dif tipo 

## roba sulla land cover per vedere l'ambiente vicino -> desertico, vedi se è dovuto principalmetne al lago o no su internet!!

## ho fatto anche i plot della qualità del lago con crop, vedi un po' cosa significano i valori 

## due siti: copernicus e quello NASA, e quello con immagini aral 
## vedi che altre robe di comandi fatti aggiungere. sicuro roba ndvi poi le altre cose sono se devo fare robe nuove più che altro 
## ricordati alla fine di mettere il codice nel code exam e mettere dei commenti vaghi, più che altro sul perchè sto facendo le cose 












