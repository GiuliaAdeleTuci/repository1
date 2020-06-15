# R_code_exam.r

# SUMMARY: 
# 1. R first code
# 2. R code multipanel 
# 3. R spatial 
# 4. R code for multivariate analysis 
# 5. R code for remote sensing
# 6. ???
# 7. R code for pca remote sensing 
# 8. R code ecosystem functions
# 9. R code for radiance 
# 10. R code faPAR
# 11. R code temp diversity, EBVs, focal on cladonia 
# 12. R code snow 
# 13. R code NO2
# 14. R code interpolation 



## 1. R code first 
# first R code
install.packages("sp") # function to install packages into R, we have to use the quotes because we go "outside R", Quotes are used for general text 

library(sp) # to recall the package, can also use require() 
data(meuse)

# seeing how the mause dataset is structured:
meuse

# let's look at the first 6 lines of the set
head(meuse)

# let's plot two variables together to see if they are correlated
# see if zinc concentration di related to the copper
attach(meuse) # first I have to attach the set to R to work with the data.
plot(zinc,copper) # to see if two variables are correlated I have to use the plot function 
plot(zinc,copper,col="red")
plot(zinc,copper,col="red",pch=19) # pch = point character, to change to symbols  
plot(zinc,copper,col="red",pch=19,cex=2) # cex = to change the dimension of the symbols 

##############################################################################################################
##############################################################################################################
##############################################################################################################

## 2. multipanle in R: second lecture of monitoring
# we use multipanel to make multiple plots together 

install.packages("sp")
install.packages("GGally")
library(GGally)
library(sp) # or require(sp)

data(meuse) # there is a dataset available

attach(meuse) # to attach the dataset, to be able to use its data

# excersise: see the names of the variables and plot cadmium and zinc 
names(meuse)
head(meuse)
plot(cadmium,zinc,pch=6,col="red",cex=2)

# excercise: make all the possible pairwise plots of the dataset, doing it by hand would be super slow, 
# plot(x,cadmium)
# plot(x,zinc)
# too long, use pairs
# To plot all variables against the others for each and for the all dataset we use pairs()
pairs(meuse)

# we are going to prettify the graphs, make it smaller 

pairs(~cadmium+copper+lead+zinc,data=meuse) 
pairs(meuse[,3:6]) # We can also plot directly from 2nd column to 6th colum → , = start from; : = until 

# excersise: prettify this graph 
pairs(meuse[,3:6],col="red",pch=6,cex=2)

# GGally will prettify the graph
ggpairs([,3:6])

# The graph obtained is → top left most of the values of cadmium are low, 
# Also the copper has a lot of small values y frequency x value 
# Correlation is index varying from -1 to 1 (spearman correlation) → 1 if they are very correlated. 

##############################################################################################################
##############################################################################################################
##############################################################################################################

## 3. Spatial R 
# R code for spatial view of points 
# we're going to show other lesson's points in space

library(sp)

data(meuse)

download.packages("ggplot2")

# to look only at the beginning of the dataset
head(meuse)

# we're going to show the points in space since they have coordinates so it is a spatial dataset
# coordinates and explain we are using x and y 
# to write ˜ it is alt+n (on mac)
coordinates(meuse) = ~x+y 

# plot of coordinates, only to see the points in space  
plot(meuse)

# plot of the sp package, explain also the variable we are going to use
spplot(meuse, "zinc") 

# excercise: spatial amount of copper + change the title with main
spplot(meuse, "copper", main = "Copper Concentration")

# function to change the size of points, the bigger the points the higher the amount of zinc
bubble(meuse, "zinc")
bubble(meuse, "zinc", main = "Zinc Concentration")

# excersise: bubble copper in red
bubble(meuse, "copper", main = "Copper Concentration", col = "red")

## importing new data
# downloaded covid_agg.csv from iol and build a folder called lab into users
# put the file in the folder lab

# setting the working directory: lab 
# for mac users
setwd("/Users/giulia/lab")

# we name the dataset covid and link it with the data using <-, so we are linking a function with an object
# plus we state that the first line is the description of the columns
covid <- read.table("covid_agg.csv", head=TRUE) 

head(covid)

# let's do a plot considering the n of cases per country 
attach(covid) # fist we attach to be able to use the dataset
plot(country,cases)

# in case you don't attach covid you should write plot(covid$country,covid$cases)
# to see all the countries we should make the labels of the countries vertical with labels which is called las
plot(country, cases, las=0) # parallel labels
plot(country, cases, las=1) # all horizontal labels
plot(country, cases, las=2) # labels are perpendicular 
plot(country, cases, las=3) # labels are vertical 

# we decrease the size of the labels of the x axis 
plot(country, cases, las=3, cex.axis=0.5)
plot(country, cases, las=3, cex.axis=0.7)

### let's plot spatially using ggplot
# to make a ggplot you need: data, aesthetic mapping which are the variables, type of symbol we want to use
# ggplot2
install.packages("ggplot2")
library(ggplot2) #or require(ggplot2)

# we saved the workspace from last lesson, so we just load it to have the data

# download data from last time 
# setting of the working directory 
setwd("/Users/giulia/lab")
# upload the previous workspace, 
load("lesson3R.RData")

#to see if there is the previous data using ls which means list 
ls()
# covid is present so the operation worked

library(ggplot2)
# on the website there are all the variables that you can use 

data(mpg)
head(mpg)
# key components: data, aes=aestethics, geometry
ggplot(mpg,aes(x=displ,y=hwy)) + geom_point()
# let's change the geometry,use lines connecting points
ggplot(mpg,aes(x=displ,y=hwy)) + geom_line()
ggplot(mpg,aes(x=displ,y=hwy)) + geom_polygon()

# let's use this with the covid data, size changes the dimension of the points according to a variable
head(covid)
ggplot(covid,aes(x=lon,y=lat,size=cases)) + geom_point()

##############################################################################################################
##############################################################################################################
##############################################################################################################
 
## 4. R code for multivariate analysis 

setwd("/users/giulia/lab")
#install.packeges("vegan")
library(vegan)

# we downloaded the dataset, now we need to make r read the table, we associate the name biomes with the functions, sep means that the columns in the original file are separated with a comma
biomes <- read.table("biomes.csv", header=T, sep=",")
head(biomes)

# we're making multivariate analysis now 
# decorana -> detrended correspondence analysis, detrending means that we show the data in 2 dimensions
multivar <- decorana(biomes) 
plot(multivar) 

# let's see how much of the analysis we are seing of our dataset
multivar
# Eigenvalues is the amount of perception of the data you have, DCA1 is the proportion of the set we see, 0.5 so 50%, DCA2 is the second dimention etc. in totale in this case we see 82% whihc is a high amount
# we can see the relationships between these species form their position in the graph 
# basically we are seing the starting points of all the 20 dimensions in 2 dimensions
# let's use the other dataset of the biome types
biomes_types <- read.table("biomes_types.csv", head=T, sep=",")
head(biomes_types)

attach(biomes_types)
# we do this because we need to use a column of the dataset, with the function ordiellipse
# we'll draw an ellipse containing all the plots of the biome
# we declare the column we are going to use, then 4 different colors for the 4 different biomes, we are using the codes of the colors
# we could also do col=c("red","green","black")

ordiellipse(multivar, type, col=1:4, kind="ehull", lwd=2) # kind is the argument and ehull is the type of graph we are using, and the dimension of the line 
# we can see that the points attaining to the biomes are nearby 

# ordispider is a different shape of graph, like a spiderweb 
ordispider(multivar, type, col=1:4, label = TRUE)

##############################################################################################################
##############################################################################################################
##############################################################################################################

## 5. R code for remote sensing data 
# we downloaded the data 
# install library raster
install.packages("raster")
install.packages("RStoolbox")

# or to install them togher 
install.packages(c("raster","RStoolbox"))

setwd("/Users/giulia/lab")
library(raster)

# we are going to import some images of satellite images of an area of Brasil + we assign a name. since these are satellite images, so they have more layers we use brick
p224r63_2011 <- brick("p224r63_2011_masked.grd")

plot(p224r63_2011) # we can see the plot of the different reflectance of bands, now we change the color ramp palette
cl <- colorRampPalette(c("black","grey","light grey"))(100)
plot(p224r63_2011, col=cl)

# bands of landsat
# B1: blue
# B2: green 
# B3: red
# B4: near infrared NIR

# let's plot these 4 bands separetely 
# multiframe of different plots all together -> function par
# and make a new col ramp palette, to see colors on R colors()
par(mfrow=c(2,2))
clb <- colorRampPalette(c("dark blue","blue","light blue"))(100)
# and plot, $ is used to link symbols 
plot(p224r63_2011$B1_sre, col=clb)

# now the green band
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
# like this we mounted the NIR on top of the red component of the RGB spectrum so all the areas reflecting in the NIR will apear red (mainly vegetation)

# put the NIR on top of the green component of the RGB
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")

# now NIR in the blue component
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")


######## second lesson 
setwd("/Users/giulia/lab")
# load the R data from last lesson function load
# we are using data from 1988 this time so make a multitemporal comparison 
library(raster)
p224r63_1988 <- brick("p224r63_1988_masked.grd")
plot(p224r63_1988)

# excersise: plot in visible RGB 321 both images
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
# we can see the two images together so we can appreciate the changes, however the vegatation is difficult to see
# show the same plot but with 432 RGBspace, to see the NIR 
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

# this function enhances the clouds and in general the noise (that's why the rivers are greenish), in 1988 the humidity was higher becuase of the higher functioning of the forest, hence the disturbance. 
# as a result is shows evaportaspiration 
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")

# we are going to use the vegetation index
dvi2011 <- (p224r63_2011$B4_sre - p224r63_2011$B3_sre)
cl <- colorRampPalette(c("purple", "light blue", "pink"))(100)
plot(dvi2011, col=cl)

# the dvi is not omogeneous, it is sensible to the amount of water as well 
# excersise: dvi for 1988
dvi1988 <- (p224r63_1988$B4_sre - p224r63_1988$B3_sre)
cl <- colorRampPalette(c("purple", "light blue", "pink"))(100)
plot(dvi1988, col=cl)
# the difference is not too high 
# difference from one year to the other
diff <- dvi2011 - dvi1988
plot(diff)

# let's see the effect of changing the grain (dimension of the pixels) 
# aggregate function, aggregates pixels to make a coarser grain, fact is the argument that indicates the factor of increase of the pixels.
# this process is called resampling 
p224r63_2011res <- aggregate(p224r63_2011, fact=10)
p224r63_2011res100 <- aggregate(p224r63_2011, fact=100)

# now we plot 
par(mfrow=c(3,1))

plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011res100, r=4, g=3, b=2, stretch="Lin")

# sometimes high detail is equal to high noise = sometimes it's better to have medium resolution 

##############################################################################################################
##############################################################################################################
##############################################################################################################

## 6. 

##############################################################################################################
##############################################################################################################
##############################################################################################################

## 7. R code for pca remote sensing 

setwd("/Users/giulia/lab")

library(raster)
library(RStoolbox)

# now we use the function brick that is used to import the whole image of the satellite. 
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

# how to plot this data by ggplot2 
library(ggplot2)
ggRGB(p224r63_2011,5,4,3)
# similar image, different way of plotting

# let's do the same with the 1988 image 
p224r63_1988 <- brick("p224r63_1988_masked.grd")
plotRGB(p224r63_1988, r=5, g=4, b=3, stretch="Lin")

# now i put together the two images
par(mfrow=c(1,2)) 
plotRGB(p224r63_1988, r=5, g=4, b=3, stretch="Lin")
plotRGB(p224r63_2011, r=5, g=4, b=3, stretch="Lin")

# let's see if the bands are correlated to eachother 
# being correlated means that you are following the pattern of another variable, 
# we are going to see if band3 is correlated to band1 so if having small values of B1 is related to the values on B3 
# first we need to know the names of those bands 
names(p224r63_2011)
#"B1_sre" "B2_sre" "B3_sre" "B4_sre" "B5_sre" "B6_bt"  "B7_sre"

# $ links the bands to the image 
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
# $ is linking all the different pieces of the output, call, model and map 

# let's change the colors
cl <- colorRampPalette(c("dark grey","grey","light grey"))(100)
plot(p224r63_2011_pca$map, col=cl)

# we want to see the info about the model 
summary(p224r63_2011_pca$model)
# we can see that PC1 is accounting for 99.83% of the whole variation 

pairs(p224r63_2011)
# to see the amount of correlation between the different data 
# we see that the whole set is hugely correlated to each other 

# now we can plot the first 3 components for example, with plotRGB
plotRGB(p224r63_2011_pca$map, r=1, g=2, b=3, stretch="Lin")

# let's do the same for the 1988 
p224r63_1988_res <- aggregate(p224r63_1988, fact=10)
p224r63_1988_pca <- rasterPCA(p224r63_1988_res)
plot(p224r63_1988_pca$map, col=cl)
# here as well we can see that the PC1 has the highest amount of information
summary(p224r63_1988_pca$model) # we see that there is high correlation 
pairs(p224r63_1988)

# now we can make a difference between the 1988 and 2011 and then plotting the difference. 
# we are making the difference of every pixel
difpca <- p224r63_2011_pca$map - p224r63_1988_pca$map
plot(difpca)

# since the PC1 contains most of the information so we can also only plot this one, only 1 layer
cldif <- colorRampPalette(c('blue','black','yellow'))(100)
plot(difpca$PC1, col=cldif)
# we see the areas that have changed most 

##############################################################################################################
##############################################################################################################
##############################################################################################################

## 8. R code to view biomass over the world and calculate changes in ecosystem functions
# energy
# chemical cycling
# proxies
install.packages("rasterdiv")
install.packages("rasterVis")
library(rasterdiv)
library(rasterVis) 

data(copNDVI) # A RasterLayer of the global average NDVI value per pixel 
plot(copNDVI)

#we need to reclassify the data by removing the data from 253:255 given the NA value, so we are removing water.
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
levelplot(copNDVI)

copNDVI10 <- aggregate(copNDVI, fact=10)
levelplot(copNDVI10)
# to make the map smoother, with lower resolution 

#10k pixels together, very coarse and low detail 
copNDVI100 <- aggregate(copNDVI, fact=100)
levelplot(copNDVI100)

# we are going to make a scenario not sustainable with life and to increase CC in the planet -> great impact 

setwd("/Users/giulia/lab")
defor1 <- brick("defor1_.jpg.png") # imports different layers at a time 
defor2 <- brick("defor2_.jpg.png")

# if you just put the name of the object in R it gives data about it 
# band1: NIR
# band2: red
# band3: green 
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin") # Red-Green-Blue plot of a multi-layered Raster object
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

#defor1_.1 etc are the names of the band, i can obtain them by running on R only the name of the object (ex. defor1)
dvi1 <- defor1$defor1_.jpg.1 - defor1$defor1_.jpg.2
dvi2 <- defor2$defor2_.jpg.1 - defor2$defor2_.jpg.2

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) 
par(mfrow=c(1,2))
plot(dvi1, col=cl)
plot(dvi2, col=cl)

#let's see the difference in the dvi between the first one and the second one 
difdvi <- dvi1 - dvi2
dev.off()
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difdvi, col=cld) 
# like this we can see where we have lost the forests. -> we see the loss of ecosystem functions (red parts = loss in biomass and related services)

#to make an histogram 
hist(difdvi) 

##############################################################################################################
##############################################################################################################
##############################################################################################################

## 9. R code for radiance 
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

##############################################################################################################
##############################################################################################################
##############################################################################################################

## 10. R code faPAR
## how to look at chemical cycling from satellites 

library(raster)
library(rasterVis)
library(rasterdiv)

# we are going to use again the copNDVI 
plot(copNDVI)

# we are removing the data from 253 to 255 and putting no value in its place, so we are removing water. 
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))

levelplot(copNDVI) # it shows also the graph of the variation of the NDVI in the different areas  
# forests that are not much structured in 3D so have similar individuals (fagus, conifers...) have very high biomass but low biodiversity

setwd("/Users/giulia/lab")

# let's import this data, 10 is becuase it is aggregated with a factor 10 
faPAR10 <- raster("faPAR10.tiff")
levelplot(faPAR10)

# we see a difference from the previous graph -> we had high NDVI in the equator and also in the forest in the north (the ones with the structure not complex in the 3D)
# instead now the huge amount of photosynthesis is in the equator since in this area all the light is used by plants (thanks to the 3D structure) while in the northern forests the values are smaller. 
# in those forests with low 3D structure some part of the light is not used and goe into the soil.

# to save images as pdf 
pdf("copNDVI.pdf")
levelplot(copNDVI)
dev.off

pdf("faPAR.pdf")
levelplot(faPAR10)
dev.off

######## lesson 2 
load("faPAR.Rdata")
# the original faPAR from copernicus is 2GB
# faPAR10 has data from values: 0, 0.9400001  (min, max), several pixels, very heavy 
# let's see the space needed for the copNDVI, 8 bit set 
library(raster)
library(rasterdiv)
writeRaster(copNDVI, "copNDVI.tif")
# only 5.5 MB -> better to use this one 

# let's make a levelplot of the faPAR
levelplot(faPAR10)


######## day 3 
# linear model between faPAR and NDVI, regression model
erosion <- c(12, 14, 16, 24, 26, 40, 55, 67)
hm <- c(30, 100, 150, 200, 260, 340, 460, 600)
plot(erosion, hm, col="red", pch=19, xlab="erosion", ylab="heavy metals", cex=2)

# let's make a linear model to see if they are related to eachother, we're extimating the slope and the intercept 
model1 <- lm(hm ~ erosion)
summary(model1) # to see the information of the model
abline(model1) # to make the regressione line in the graph 

# let's do the same for the faPAR and NDVI 
setwd("/Users/giulia/lab")
library(raster)
library(rasterdiv)
faPAR10 <- raster("faPAR10.tiff")
plot(copNDVI)

# let's remove the water values from the copNDVI
copNDVI <- reclassify(copNDVI, cbind(253:255, NA), right=TRUE)

# now we have two variables (faPAR and copNDVI) and we want to see if they are related
# first we want to see the amount of cells in each raster, we see that the faPAR10 has a lot of cells so we want to use only a sample 
library(sf) # to call st_* functions
random.points <- function(x,n)
{
lin <- rasterToContour(is.na(x))
pol <- as(st_union(st_polygonize(st_as_sf(lin))), 'Spatial') # st_union to dissolve geometries
}
pts <- random.points(faPAR10,1000)
# now we have the random points that we will use (1k) 

copNDVIp <- extract(copNDVI,pts) # to extract data from the image into a table
faPAR10p <- extract(faPAR10,pts)

plot(copNDVIp,faPAR10p)

model2 <- lm(faPAR10p~copNDVIp)
summary(model2)
# we see through the r squared and the p-value that the correlation is not random
plot(copNDVIp,faPAR10p,col="green")
abline(model1,col="red")
# we can see that the two values are quite related with some exceptions (like conifer forests with a lot of biomass and low photosynthesis)

##############################################################################################################
##############################################################################################################
##############################################################################################################

## 11. R code temp diversity, EBVs, focal on cladonia 
### diversity measurement
setwd("/Users/giulia/lab") 

library(raster)
# now we import the image: we can use raster which imports one single layer and brick which imports the whole image (different layers at a time)
snt <- brick("snt_r10.tif")
plot(snt)

# let's use plotRGB whici is used to plot the layers corresponding to the different color bands 
#B1 is blue
#B2 green
#B3 red
#B4 NIR

plotRGB(snt, 3, 2, 1, stretch="Lin") # like this we plot the image as the human eye would see it

plotRGB(snt, 4, 3, 2, stretch="Lin") #NIR on top of red, vegetation is then colored red

pairs(snt) # to produce a matrix of scatterplots 

# for the PCA analysis 
library(RStoolbox)

sntpca <- rasterPCA(snt)
sntpca

summary(sntpca$model) # to have info, we see tht 70% of the info is carried by the first component -> good approximation 
plot(sntpca$map)

plotRGB(sntpca$map, 1,2,3, stretch="Lin")

# we're making use of the moving window on the PC1 to see the different sd
# set the moving window of 5x5 pixels
window <- matrix(1, nrow = 5, ncol = 5)
window 

# now we apply the window (focal measurement) to the PC1, the functions that can be used are several, we are using the standard deviation 
sd_snt <- focal(sntpca$map$PC1, w=window, fun=sd)

cl <- colorRampPalette(c('dark blue','green','orange','red'))(100) 
plot(sd_snt, col=cl)
# we see low variability in the forest area and higher variability in the areas passing from forest to different ecosystems outside. 

# let's plot together the RGB plot and the one with the sd 
par(mfrow=c(1,2))
plotRGB(snt, 4, 3, 2, stretch="Lin")
plot(sd_snt, col=cl)
# the second plot highlights the borders between environments, max variability 

### lesson 2
# same analysis with a field image on lichens, cladonia 
setwd("/Users/giulia/lab")
library(raster) 
clad <- brick("cladonia_stellaris_calaita.JPG")
plotRGB(clad,1,2,3, stretch="lin")  

# we define the window 3x3 
window <- matrix(1, nrow = 3, ncol = 3)
window

# now we use the focal function 
# we will apply it to a specific band of the image, we will use the very first band 
pairs(clad) # to see how much they are correlated 

# we can also use the pca 
library(RStoolbox)
cladpca <- rasterPCA(clad) # this was we have the first component that expalins 99% of it

# we can use the cladpca to the the data which is the output of the function 
cladpca 

# let's see how much info is explained by the first pca 
summary(cladpca$map) 
# 98% is explained bu the first component 
plotRGB(cladpca$map, 1, 2, 3, stretch="lin")

# let's make the measurement of the cladonia through the moving window, to see the diversity 
sd_clad <- focal(cladpca$map$PC1, w=window, fun=sd)

PC1_agg <- aggregate(cladpca$map$PC1, fact=10) # we aggregate the image wit ha factor of 10 
sd_clad_agg <- focal(PC1_agg, w=window, fun=sd)

par(mfrow=c(1,2))
cl <- colorRampPalette(c('yellow', 'violet', 'black'))(100) 
plot(sd_clad, col=cl)
plot(sd_clad_agg, col=cl)

# the meaning: we see that all the microvariability in the strucutre of cladonia can be measured, it tells the complexity of the structure of the organism

plotRGB(clad, 1,2,3, stretch="lin")
plot(sd_clad_agg, col=cl)
 
##############################################################################################################
##############################################################################################################
##############################################################################################################

## 12. R code snow 
# R_code_snow.r
setwd("/Users/giulia/lab") 
library(raster)
library(ncdf4)

# let's import the image from copernicus (we previously dowloaded it from the website)
snowmay <- raster("c_gls_SCE_202005260000_NHEMI_VIIRS_V1.0.1.nc")
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100) 

plot(snowmay, col=cl) 

# to have info about the n of pixels
snowmay 

### how to import multiple data together form copernicus 
## slow manner, one by one using raster 
setwd("/Users/giulia/lab/snow") 
snow2000 <- raster("snow2000r.tif")
snow2005 <- raster("snow2005r.tif")
snow2010 <- raster("snow2010r.tif")
snow2015 <- raster("snow2015r.tif")
snow2020 <- raster("snow2010r.tif")

# then to plot we use par 
par(mfrow=c(2,3))
plot(snow2000, col=cl)
plot(snow2005, col=cl)
plot(snow2010, col=cl)
plot(snow2015, col=cl)
plot(snow2020, col=cl)

## fast way 
# function lapply -> applies a function considering a list of files/objects all together  
# first we have to make the list of files -> list.files, with a common pattern 
rlist <- list.files(pattern="snow")
rlist

import <- lapply(rlist, raster) 

# now that we have imported the files we can apply the stack to make a stack of several layers
snow.multitemp <- stack(import)
plot(snow.multitemp, col=cl)

# now we can make a prediction 
library(rgdal)

# define the extent
ext <- c(-180, 180, -90, 90)
extension <- crop(snow.multitemp, ext) # crop returns a geographic subset of an object
    
# make a time variable (to be used in regression)
time <- 1:nlayers(snow.multitemp)

# run the regression
fun <- function(x) {if (is.na(x[1])){ NA } else {lm(x ~ time)$coefficients[2] }} 
predicted.snow.2025 <- calc(extension, fun) 

predicted.snow.2025.norm <- predicted.snow.2025*255/53.90828

# we can also simply import the code with the source function 
source("prediction.r")


### lesson 2
# exercise: import all the snow cover images together
library(raster) 
rlist <- list.files(pattern="snow")
import <- lapply(rlist, raster) 
snow.multitemp <- stack(import)
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100)
plot(snow.multitemp, col=cl)

# let's import the prediction image from last lesson 
prediction <- raster("predicted.2025.norm.tif")
plot(prediction, col=cl)

# how to export the output, first you write the name of what you want to export, and then the name you want it saved with. 
writeRaster(prediction, "final.tif")
# this function creates the data, it's not only an image. it's the opposite of the raster function  

# or to have a pdf of the graph
final.stack <- stack(snow.multitemp, prediction)
# we are stacking all together, at the end we will have a stack of the snow.multitemp + the prediciton (6 images). 
plot(final.stack, col=cl)

# now we export this graph with all the plots 
pdf("my_final_graph.pdf") # this is the name 
plot(final.stack, col=cl) # this goes inside the pdf
dev.off()

png("my_final_graph.png") # this is the name 
plot(final.stack, col=cl) # this goes inside the pdf
dev.off()

##############################################################################################################
##############################################################################################################
##############################################################################################################

## 13. R code NO2
# R code for NO2 monitoring 
# we placed the files in a folder so that we can import them all together

setwd("/Users/giulia/lab/no2") 

library(raster)

# we create a list of files 
rlist <- list.files(pattern="EN")
rlist

# now we apply the raster function to all the objects in the list at the same time
import <- lapply(rlist, raster) 

# we create a stack of all the rasters 
EN <- stack(import)
cl <- colorRampPalette(c('blue','green','red'))(100) 

# we then plot them 
plot(EN, col=cl)

# let's plot the first one and the last one only to see the difference, january and march
par(mfrow=c(1,2))
plot(EN$EN_0001, col=cl)
plot(EN$EN_0013,col=cl)

# we can also make a RGB space, putting the R = EN_0001, G=0007 and B=0013, so that if the levels in the beginning were higher we sill se it in red
# in green we see the middle level and in blue the lastest values (march)
# firts dev.off()
plotRGB(EN, r=1, g=7, B=13, stretch='lin') 

# let's make a difference map 
dif <- EN$EN_0013 - EN$EN_0001
cld <- colorRampPalette(c('blue', 'white', 'red'))(100)
plot(dif,col=cld)

# let's make a boxplot of the whole stack
boxplot(EN)

# there are a lot of outliers, let's remove them 
boxplot(EN, outline=F)

# let's move the boxplots horizontal 
boxplot(EN, outline=F, horizontal=T)

# let's add the axes to make it easier to read
boxplot(EN, outline=F, horizontal=T, axes=T)

# we can see that the first image is in the bottom 
# we see that there is a negative exponential decrease in terms of no2, the max values in decreasing 

# we can plot the data of the first image and the data from the last image, 
# if it decreased most of the points should be under the 1 to 1 line
plot(EN$EN_0001, EN$EN_0013) 

# to insert the 1 to 1 line, y=x 
abline(0,1, col='red')
# we see that most of the data are under the curve -> it decreased

setwd("/Users/giulia/lab/snow")
rlist <- list.files(pattern="snow20")
rlist

import <- lapply(rlist, raster)
snow.multitemp <- stack(import)

plot(snow.multitemp)

# let's make some differences 
plot(snow.multitemp$snow2010r, snow.multitemp$snow2020r)
abline(0,1, col='red')

plot(snow.multitemp$snow2000r, snow.multitemp$snow2020r)
abline(0,1, col='red')

##############################################################################################################
##############################################################################################################
##############################################################################################################

## 14. R code interpolation
# R_code_interpolation

# steps
# step 1: explain to spatstat that we are going to use coordinates: ppp
# step 2: explain the variable we are going to use: marks
# step 3: smooth
# step 4: plot the final result 

library(spatstat)
inp <- read.table("dati_plot55_LAST3.csv", sep=";", head=T)

head(inp)
attach(inp) #since we attached we don't need to use the $
plot(X,Y)
# planar point pattern, explain the range of the coordinates, to see the min and max we use summary 
summary(inp)
inppp <- ppp(x=X, y=Y, c(716000,718000),c(4859000,4861000))

marks(inppp) <- Canopy.cov # to label the single points, with the canopy cover 
# for each pixel we'll make an estimate of its value
canopy <- Smooth(inppp)
plot(canopy)
points(inppp, col="green")

# let's see the lichens which are an index for air quality 
marks(inppp) <- cop.lich.mean
lichs <- Smooth(inppp)
plot(lichs)
points(inppp)

par(mfrow=c(1,2))
plot(canopy)
points(inppp)
plot(lichs)
points(inppp)

par(mfrow=c(1,3))
plot(canopy)
points(inppp)
plot(lichs)
points(inppp)
plot(Canopy.cov, cop.lich.mean, col="red", pch=19, cex=2)
# to make a graph to see the correlation 

 #### second analysis 
inp.psam <- read.table("dati_psammofile.csv", sep=";", head=T)

attach(inp.psam)

summary(inp.psam)

plot(E,N) # clumped pattern 
inp.psam.ppp <- ppp(x=E,y=N,c(356450,372240),c(5059800,5064150))

marks(inp.psam.ppp) <- C_org
C <- Smooth(inp.psam.ppp)
plot(C)
points(inp.psam.ppp)

##############################################################################################################
##############################################################################################################
##############################################################################################################

## 15. R code sdm 
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

##############################################################################################################
##############################################################################################################
##############################################################################################################








 































































