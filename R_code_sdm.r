# species distribution modelling

library(sdm)
library(raster) # predictors
library(rgdal) # species 

# species, presence/absence 
file <- system.file("external/species.shp", package="sdm") 
species <- shapefile(file) # shapefile is a common datatype .shp

# we are coupling the visual part and the points inside 

species
species$Occurrence # table with absence/presence of species, 0 or 1 
plot(species)

plot(species[species$Occurrence == 1,],col='blue',pch=16) # to only plot the presences 

points(species[species$Occurrence == 0,],col='red',pch=16) # to add the other points to the plot, the absences 

# environmental variables
path <- system.file("external", package="sdm") # the path towards the folder called external 

lst <- list.files(path=path,pattern='asc$',full.names = T) # we need to make a list of files in that path, stating the pattern 
lst # we see that there are multiple groups of data, so we make a stack 

preds <- stack(lst)
plot(preds)

cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl)

# we want to see where the species is present, we are doing this with every variable 
plot(preds$elevation, col=cl)
points(species[species$Occurrence == 1,], pch=16) 

plot(preds$temperature, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$precipitation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$vegetation, col=cl) # this index is based on the red and infrared difference 
points(species[species$Occurrence == 1,], pch=16)

# model -> we put all the information together 

d <- sdmData(train=species, predictors=preds)
d # to have all the info about d 

# sdm = species distribution model 
# glm = generalized linear model, we are putting all together 
m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=d, methods='glm') 
p1 <- predict(m1, newdata=preds) # newdata is the argument that defines the predictors used fort he final prediction 

plot(p1, col=cl)
points(species[species$Occurrence == 1,], pch=16)

# this plot shows the probability of distribution of the species in space,
# we see that the highest probability of having the species is in the parts where the species is actually present (from the data)
# we see that there are some errors, area with low prediction with actually the presence of the species. 

# we can make the final stack with all the predictors and variables
s1 <- stack(preds,p1)

plot(s1, col=cl)

# we see all the variables and we can compare them with the model of the species distribution 




