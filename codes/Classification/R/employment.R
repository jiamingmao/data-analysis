###############
## Employment #
###############
## Code to accompany Lecture on 
## Classification
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io

library(mlogit)
library(ramify)
library(ggplot2)
library(ggthemes)
library(descr)
set.seed(123)

## reading data
rm(list = ls())
emp <- read.csv("employment.csv")
emp$sex <- factor(emp$sex,labels=c("male","female"))
N = nrow(emp) 
J = length(levels(emp$sector))

## visualize
freq(emp$sector,plot=FALSE) #require("descr")
aggregate(wage ~ sector,emp,mean)
plot(emp$sector,emp$sex,ylab="",xlab="")
ggplot(emp, aes(x = sector, y = education)) + geom_boxplot() + theme_economist() + scale_colour_economist()

## counterfactual wage
emp0 <- emp #preserve the original data

wfit1 <- glm(wage ~ sex*education, emp[emp$sector=="education",], 
             family=quasipoisson) 
emp$wage.education <- predict(wfit1,emp,type="response")
wfit2 <- glm(wage ~ sex*education, emp[emp$sector=="health",], 
             family=quasipoisson) 
emp$wage.health <- predict(wfit2,emp,type="response")
wfit3 <- glm(wage ~ sex*education, emp[emp$sector=="manufacturing",], 
             family=quasipoisson) 
emp$wage.manufacturing <- predict(wfit3,emp,type="response")
wfit4 <- glm(wage ~ sex*education, emp[emp$sector=="personal",], 
             family=quasipoisson) 
emp$wage.personal <- predict(wfit4,emp,type="response")
wfit5 <- glm(wage ~ sex*education, emp[emp$sector=="professional",], 
             family=quasipoisson) 
emp$wage.professional <- predict(wfit5,emp,type="response")
wfit6 <- glm(wage ~ sex*education, emp[emp$sector=="retail",], 
             family=quasipoisson) 
emp$wage.retail <- predict(wfit6,emp,type="response")

emp <- emp[,-c(1:3)]

##################################
# Estimate Discrete Choice Model #
##################################
emp.long <- mlogit.data(emp, shape="wide", varying=2:7, choice="sector") 
fit <- mlogit(sector ~ wage, emp.long)
summary(fit)

#######################
# Welfare Calculation #
#######################
b <- coef(fit)["wage"]
X <- model.matrix(fit)
V <- X %*% coef(fit)
V <- matrix(V,N,J,byrow=TRUE)
U = log(rowSums(exp(V)))/b
summary(U)

##################################################
# Experiment: 20% decrease in Manufacturing wage #
##################################################
# predicting sector share
emp2 <- emp
emp2$wage.manufacturing <- emp$wage.manufacturing*0.8
emp2.long <- mlogit.data(emp2, shape="wide", varying=2:7, choice="sector")
colMeans(predict(fit,emp2.long))

# welfare calculation
X2 <- X 
X2[index(emp.long)$alt=="manufacturing","wage"] = X2[index(emp.long)$alt=="manufacturing","wage"]*.8 
V2 <- X2 %*% coef(fit) 
V2 <- matrix(V2,N,J,byrow=TRUE) 
U2 = log(rowSums(exp(V2)))/b
summary(U2)

dU = U2 - U
summary(dU)
emp.final = data.frame(emp0,U,U2,dU) 
aggregate(dU ~ education,emp.final,mean)
aggregate(dU ~ sex,emp.final,mean)
