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



