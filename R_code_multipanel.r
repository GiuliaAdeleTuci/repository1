### multipanle in R: second lecture of monitoring

install.packages("sp")
install.packages("GGally")
library(GGally)
library(sp) #require(sp)

data(meuse) #there is a dataset available

attach(meuse) #to attach the dataset

#excersise: see the names of the variables and plot cadmium and zinc 
names(meuse)
head(meuse)
plot(cadmium,zinc,pch=6,col="red",cex=2)

# excercise: make all the possible pairwise plots of the dataset, doing ti by hand would be super slow, 
# plot(x,cadmium)
# plot(x,zinc)
# too long, use pairs
pairs(meuse)

#we are going to prettify the graphs, make it smaller 

pairs(~cadmium+copper+lead+zinc,data=meuse) 
pairs(meuse[,3:6])

#excersise: prettify this graph 
pairs(meuse[,3:6],col="red",pch=6,cex=2)

#GGally will prettify the graph
ggpairs([,3:6])
