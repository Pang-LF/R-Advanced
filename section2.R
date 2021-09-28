setwd('/Users/Lotus/Desktop/stevens/job/R_projects')
getwd()
# basic: fin <- read.csv('Future 500.csv')
fin <- read.csv('Future 500.csv',na.strings = c(''))
fin
head(fin)
tail(fin,10)
str(fin)
summary(fin)

#changing from non-factor to factor
fin$ID<-factor(fin$ID)
fin$Name<-factor(fin$Name)
fin$Industry <-factor(fin$Industry)
fin$Inception<-factor(fin$Inception)
fin$State<-factor(fin$State)
fin$City<-factor(fin$City)
fin$Revenue<-factor(fin$Revenue)
fin$Expenses<-factor(fin$Expenses)
fin$Growth<-factor(fin$Growth)
str(fin)
summary(fin)

# remove the charactors and to a numerics
fin$Expenses <- gsub('Dollars','',fin$Expenses)
fin$Expenses <- gsub(',','',fin$Expenses)
str(fin)

fin$Revenue <- gsub('\\$','',fin$Revenue)
fin$Revenue <- gsub(',','',fin$Revenue)
str(fin)

fin$Growth <- gsub('%','',fin$Growth)
str(fin)

fin$Expenses <-as.numeric(fin$Expenses)
fin$Revenue <-as.numeric(fin$Revenue)
fin$Growth <-as.numeric(fin$Growth)
summary(fin)

#dealing with missing data
head(fin,24)
fin[!complete.cases(fin),]

#filtering: using which() for non-missing data
fin[which(fin$Revenue == 9746272,),]

#filtering: using is.na() for missing data
fin[is.na(fin$Expenses),]
fin[is.na(fin$State),]

#remove records with missing data
fin_backup <- fin
fin <- fin_backup
fin <- fin[!is.na(fin$Industry),]
fin[!complete.cases(fin),]

# resetting the dataframe index
# rownames(fin) <- 1:nrows(fin)
rownames(fin) <- NULL
fin

# replacing missing data: factual analysis
fin[is.na(fin$State)& fin$City=='New York','State'] <- 'NY'
fin[is.na(fin$State)& fin$City=='San Francisco','State'] <- 'CA'
fin[!complete.cases(fin),]

#replacing missing data: median imputation method
med_empl_retail<-median(fin[fin$Industry =='Retail','Employees'],na.rm=TRUE)
fin[is.na(fin$Employees)& fin$Industry =='Retail','Employees']<-med_empl_retail
#check
fin[3,]

med_empl_financial<-median(fin[fin$Industry =='Financial Services','Employees'],na.rm=TRUE)
fin[is.na(fin$Employees)& fin$Industry =='Financial Services','Employees']<-med_empl_financial
fin[330,]

med_growth_constr<-median(fin[fin$Industry =='Construction','Growth'],na.rm=TRUE)
fin[is.na(fin$Growth)& fin$Industry=='Construction','Growth']<-med_growth_constr

med_rev_constr<- median(fin[fin$Industry=='Construction','Revenue'],na.rm=TRUE)
fin[is.na(fin$Revenue)&fin$Industry=='Construction','Revenue']<-med_rev_constr

med_exp_constr<- median(fin[fin$Industry=='Construction','Expenses'],na.rm=TRUE)
fin[is.na(fin$Expenses)&fin$Industry=='Construction','Expenses']<-med_exp_constr

#replacing missing data with deriving values
fin[is.na(fin$Profit),'Profit']<-fin[is.na(fin$Profit),'Revenue']-fin[is.na(fin$Profit),'Expenses']
fin[is.na(fin$Expenses),'Expenses']<-fin[is.na(fin$Expenses),'Revenue']-fin[is.na(fin$Expenses),'Profit']

# visualization
install.packages('ggplot2')
library(ggplot2)
#point
p<-ggplot(data=fin)
p
p+geom_point(aes(x=Revenue,y=Expenses,colour=Industry,size = Profit))

d<- ggplot(data = fin,aes(x=Revenue,y=Expenses,colour=Industry))
d+geom_point()+geom_smooth(fill=NA,size=1.2)
#boxplot
f <- ggplot(data=fin,aes(x=Industry,y=Growth,colour=Industry))
f+geom_boxplot(size=1)
#extra
f+geom_jitter()+geom_boxplot(size=1,alpha=0.5,outlier.colour = NA)
