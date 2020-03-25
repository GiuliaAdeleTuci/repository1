install.packages("sp")

library(sp)
data(meuse)

# seeing how the mause dataset is structured:
meuse

#let's look at the first rows of the set
head(meuse)

#let's plot two variables together to see if they are correlated
#see if zinc concentration di related to the copper
attach(meuse)
plot(zinc,copper)
plot(zinc,copper,col="red")
plot(zinc,copper,col="red",pch=19)
plot(zinc,copper,col="red",pch=19,cex=2)
