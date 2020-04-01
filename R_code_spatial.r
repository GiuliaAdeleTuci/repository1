# R code for spatial view of points 
# we're going to show other lesson's points in space

library(sp)

data(meuse)

# to look only at the beginning of the dataset
head(meuse)

# we're going to show the points in space since they have coordinates so it is a spatial dataset
# coordinates and explain we are using x and y 
# to write ˜ it is alt+n 
coordinates(meuse) = ~x+y 

# plot of coordinates, only to see the points in space  
plot(meuse)

# plot of the sp package explain also the variable we are going to use
spplot(meuse, "zinc") 

# excercise: spatial amount of copper + change the title with main
spplot(meuse, "copper", main = "Copper Concentration")

# function to change the size of points, the bigger the points the higher the amount of zinc
bubble(meuse, "zinc")
bubble(meuse, "zinc", main = "Zinc Concentration")

#excersise: bubble copper in red
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
attach(covid)
plot(country,cases)

#in case you don't attach covid you should write plot(covid$country,covid$cases)
#to see all the countries we should make the labels of the countries vertical with labels which is called las
plot(country, cases, las=0) #parallel labels
plot(country, cases, las=1) # all horizontal labels
plot(country, cases, las=2) # labels are perpendicular 
plot(country, cases, las=3) # labels are vertical 

# we decrease the size of the labels of the x axis 
plot(country, cases, las=3, cex.axis=0.5)
plot(country, cases, las=3, cex.axis=0.7)

# let's plot spatially using ggplot
# to make a ggplot you need: data, aesthetic mapping which are the variables, type of symbol we want to use
#ggplot2
install.packages("ggplot2")
library(ggplot2) #or require(ggplot2)




