########################
## Credit Card Default #
########################
## Code to accompany Lecture on 
## Classification
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io

library(ISLR)
library(AER)
library(class)
library(lattice)
library(MASS)
library(gmodels)

## reading data
rm(list = ls())
attach(Default)
Default <- Default[,-2] #we don't use the student variable
dim(Default)
head(Default)
set.seed(123) 
source("roc.R")

## Visualize
#par(mfrow=c(1,1))
xyplot(income ~ balance,groups=default)

#############
## Logistic #
#############
logitfit <- glm(default ~., data=Default, family=binomial)
summary(logitfit)
logit.p <- logitfit$fit

dnames = c("predicted default","true default")

# cutoff = 0.5
cutoff1 <- .5
logit.y <- as.factor(logit.p > cutoff1)
levels(logit.y) <- c("No","Yes")
table(logit.y,default,dnn=dnames)
CrossTable(logit.y,default,digits=2,prop.r=FALSE,prop.t=FALSE,prop.chisq=FALSE,
           dnn=dnames,format="SPSS")

# cutoff = 0.1
cutoff2 <- .1
logit.y <- as.factor(logit.p > cutoff2)
levels(logit.y) <- c("No","Yes")
table(logit.y,default,dnn=dnames)
CrossTable(logit.y,default,digits=2,prop.r=FALSE,prop.t=FALSE,prop.chisq=FALSE,
           dnn=dnames,format="SPSS")

## ROC
roc(p=logit.p,y=default,col="darkred")

points(x= 1-mean((logit.p<=cutoff1)[default=="No"]), 
       y=mean((logit.p>cutoff1)[default=="Yes"]), 
       cex=1.5, pch=20, col='forestgreen') 

points(x= 1-mean((logit.p<=cutoff2)[default=="No"]), 
       y=mean((logit.p>cutoff2)[default=="Yes"]), 
       cex=1.5, pch=20, col='blue') 

legend("bottomright",fill=c("forestgreen","blue"),
       legend=c(paste("Threshold 1: ",cutoff1),
                paste("Threshold 2: ",cutoff2)),bty="n")

##
detach(Default)

