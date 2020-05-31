### multipanle in R: second lecture of monitoring
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
