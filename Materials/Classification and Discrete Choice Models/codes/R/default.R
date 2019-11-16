########################
## Credit Card Default #
########################
## Code to accompany Lecture on 
## Classification and Discrete Choice Models
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io/data-analysis/

library(ISLR)
library(gmodels)

## reading data
rm(list = ls())
attach(Default)
Default <- Default[,-2] #we don't use the student variable
dim(Default)
head(Default)
set.seed(123) 

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

##
detach(Default)

