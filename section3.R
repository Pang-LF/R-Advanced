setwd('/Users/Lotus/Desktop/stevens/job/R_projects')
util <- read.csv('Machine-Utilization.csv')
head(util,20)
util$Timestamp <- factor(util$Timestamp)
util$Machine <- factor(util$Machine)
str(util)
summary(util)
#Derive utilization column
util$Utilization <- 1 - util$Percent.Idle
head(util,12)

# handling date-time in R
util$PosixTime <- as.POSIXct(util$Timestamp,format='%d/%m/%Y %H:%M')
head(util,12)
summary(util)

# how to rearrange columns in a df
util$Timestamp <- NULL
util <- util[,c(4,1,2,3)]
head(util,12)

# what is a list
RL1 <- util[util$Machine=='RL1',]
RL1$Machine <- factor(RL1$Machine)
util_stats_rl1 <- c(min(RL1$Utilization,na.rm=T),
                    mean(RL1$Utilization,na.rm=T),
                    max(RL1$Utilization,na.rm=T))
util_stats_rl1

util_under_90_flag <- length(which(RL1$Utilization<0.90))>0
util_under_90_flag 

list_rl1 <- list('RL1',util_stats_rl1,util_under_90_flag)
list_rl1

#naming components of a list
names(list_rl1)<- c('Machine','Stats','LowThreshold')

rm(list_rl1)
list_rl1 <- list(Machine='RL1',Stats=util_stats_rl1,LowThreshold=util_under_90_flag)
list_rl1

#extracting components of a list
list_rl1[1]
list_rl1[[1]]
list_rl1$Machine

#adding and deleting list components
list_rl1[4]<- 'New Information'
list_rl1$UnknownHours <- RL1[is.na(RL1$Utilization),'PosixTime']
list_rl1

#remove a component
list_rl1[4] <-NULL #index shifted
# add another component
list_rl1$Data <- RL1
summary(list_rl1)
str(list_rl1)

#subsetting a list
list_rl1[[4]][1]
list_rl1[1:3]
sublist_rl1 <- list_rl1[c('Machine','Stats')]
sublist_rl1[[2]][2]

library(ggplot2)
p <- ggplot(data=util)
myplot<-p+geom_line(aes(x=PosixTime,y=Utilization,colour=Machine),size=1.2)+
  facet_grid(Machine~.)+
  geom_hline(yintercept = 0.9,colour='Grey',size = 1.2,linetype=3)
list_rl1$Plot <- myplot
