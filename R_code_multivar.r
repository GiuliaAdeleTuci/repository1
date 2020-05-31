## R code for multivariate analysis 

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








