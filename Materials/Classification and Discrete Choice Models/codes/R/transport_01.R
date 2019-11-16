###################
## Transportation #
###################
## Code to accompany Lecture on 
## Classification and Discrete Choice Models
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io/data-analysis/

## reading data
rm(list = ls())
transport <- read.csv("Transport.txt")
loginc <- transport$LogIncome
distance <- transport$DistanceToWork
y <- transport$ModeOfTransportation
N <- nrow(transport)

## logistic regression
require(nnet)
logitfit <- multinom(y ~ loginc + distance) 
summary(logitfit)

## prediction
logit.yhat <- predict(logitfit)
table(logit.yhat,y)
sum(diag(table(logit.yhat,y)))/N

## counterfactual prediction: without subway
logit.pr <- predict(logitfit,type="probs")
logit.pc <- logit.pr[,c(1,2)] # without subway
logit.yc <- as.factor(argmax(logit.pc))
levels(logit.yc) <- c("bus","car")
table(logit.yc,logit.yhat)

## market share comparison
marketshare.y = colMeans(logit.pr)
marketshare.y
marketshare.c = colMeans(logit.pc)
marketshare.c
