# how to look at chemical cycling from satellites 

library(raster)
library(rasterVis)
library(rasterdiv)

# we are going to use again the copNDVI 
plot(copNDVI)

# we are removing the data from 253 to 255 and putting no value in its place, so we are removing water. 
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))

levelplot(copNDVI) # it shows also the graph of the variation of the NDVI in the different areas  
# forests that are not much structured in 3D so with similar individuals (fagus, conifers...) have very high biomass but low biodiversity

setwd("/Users/giulia/lab")

# let's import this data, 10 is becuase it is aggregated with a factor 10 
faPAR10 <- raster("faPAR10.tiff")
levelplot(faPAR10)

# we see a difference from the previous graph -> we had high NDVI in the equator and also in the forest in the north (the ones with the structure we said before)
# instead now the huge amount of photosynthesis is in the equator since in this area all the light is used by plants (fro the 3D structure) while in the northern forests the values are smaller. 
# in those forests with low 3D structure some part of the light is not used and goes into the soil. 

# to save images as pdf 
pdf("copNDVI.pdf")
levelplot(copNDVI)
dev.off

pdf("faPAR.pdf")
levelplot(faPAR10)
dev.off
