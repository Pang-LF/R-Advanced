getwd()
setwd('/Users/Lotus/Desktop/stevens/job/R_projects/Weather Data')
Chicago <- read.csv('Chicago-F.csv',row.names=1)
NewYork <- read.csv('NewYork-F.csv',row.names=1)
Houston <- read.csv('Houston-F.csv',row.names=1)
SanFrancisco <- read.csv('SanFrancisco-F.csv',row.names=1)

#check dataframes
is.data.frame(Chicago)
# convert to matrices
Chicago <- as.matrix(Chicago)
NewYork <- as.matrix(NewYork)
Houston <- as.matrix(Houston)
SanFrancisco <- as.matrix(SanFrancisco)

is.matrix(Chicago)
Weather <- list(Chicago=Chicago,NewYork=NewYork,Houston=Houston,SanFrancisco=SanFrancisco)
Weather

#using apply()
apply(Chicago,1,mean)
#analyze one city
apply(Chicago,1,max)
apply(Chicago,1,min)

#recreating the apply function with loops
#via loops
output <- NULL
for(i in 1:5){
  output[i] <- mean(Chicago[i,])
}
names(output) <-rownames(Chicago)
output

#using lapply()
mynewlist <- lapply(Weather,t)
mynewlist

rbind(Chicago,NewRow=1:12)
lapply(Weather,rbind,NewRow=1:12)

rowMeans(Chicago)  
lapply(Weather,rowMeans)
#rowMeans(),colMeans(),rowSums(),colSums()
#combining lapply with []
lapply(Weather,'[',1,1)
lapply(Weather, '[',1,)
lapply(Weather,'[', ,3)

# adding your own functions
lapply(Weather,rowMeans)
lapply(Weather,function(x) x[5,])
lapply(Weather,function(z) round((z[1,]-z[2,])/z[2,],2))

#using sapply() 
sapply(Weather,'[',1,10:12)
round(sapply(Weather,rowMeans),2)
sapply(Weather,function(z) round((z[1,]-z[2,])/z[2,],2))

#nesting apply function
apply(Chicago,1,max)
sapply(Weather, apply,1,max) 
#sapply(Weather, function(x) apply(x,1,max))

#which.max & which.min
which.max(Chicago[1,])
names(which.max(Chicago[1,]))
apply(Chicago, 1,function(x) names(which.max(x)))
sapply(Weather,apply,1,function(x) names(which.max(x)))