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
