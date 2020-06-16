
setwd("/Users/giulia/pro/landcovercl")
library(raster)
library(RStoolbox)
lcover01 <- brick("MCD12C1_T1_2001-01-01_rgb_3600x1800.TIFF")
cl <- colorRampPalette(c("green","yellow","brown"))(100)
plot(lcover01, col=cl)
ext <- c(41,48, 56,63)
zoom(lcover01,ext=ext)
# non funziona
zoom(lcover01, ext=drawExtent())
# salvo 

plot(lcover01, col=cl, main="Land Cover")

pdf("land_cover_2001.pdf")
plot(lcover01, col=cl, main="Land Cover 2001")
dev.off()

# ora facciamo del 2011
lcover11 <- brick("RenderData2011-2")
plot(lcover01, col=cl, main="Land Cover")

pdf("land_cover_2011.pdf")
plot(lcover01, col=cl, main="Land Cover 2011")
dev.off()

par(mfrow=c(1,2))
plot(lcover01, col=cl, main="Land Cover 2001")
plot(lcover01, col=cl, main="Land Cover 2011")


rlist <- list.files(pattern="LandCover")
rlist

import <- lapply(rlist, raster) 

land.multitemp <- stack(import)
plot(land.multitemp, col=cl)

library(rgdal)

ext <- c(41,48, 56,63)
extension <- crop(land.multitemp, ext)
plot(extension)

pdf("land_cover.pdf")
plot(land.multitemp, col=cl)
dev.off()

lcover1 <- brick("LandCover2001.TIFF")
lcover11 <- brick("LandCover2011")
ext <- c(41,48, 56,63)
extension1 <- crop(lcover1, ext)
extension11 <- crop(lcover11, ext)

diff <- extension11-extension1
diff
# vedo che values sono -13 a 9 
# quindi c'è stata variazione, più verso il - per altro => ??


## proviamo con il lake water wuality 








