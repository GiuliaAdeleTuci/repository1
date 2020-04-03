### Point pattern analysis: Density Map

install.packages("spatstat")
library(spatstat)
attach(covid)
head(covid)

#let's give a name to what we are about to make -> covids. ppp is planet point pattern 
#then explain x and y variables and the range for the numbers with c
covids <- ppp(lon, lat, c(-180,180), c(-90,90))
#if i put ?ppp R will explain the function 

#density of the covids object that we created before
d <- density(covids)
#to show the map i use plot
plot(d)

#let's put the points inside this plot
points(covids)


