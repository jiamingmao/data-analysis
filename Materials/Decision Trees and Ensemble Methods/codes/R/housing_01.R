##########################
## Boston Housing Prices #
##########################
## Code to accompany Lecture on 
## Decision Trees and Ensemble Methods
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io/data-analysis

library(MASS)
library(rpart)
library(randomcoloR)
rm(list=ls())
set.seed(100)

# data
attach(Boston)
n = nrow(Boston)
lncrime = log(crim)
Boston$lncrime = log(Boston$crim)
crimelims = range(lncrime)
crime.grid = seq(crimelims[1],crimelims[2],0.01)

########################################
# Median House Price on Log Crime Rate #
########################################

## Fit a single stump
fit = rpart(medv~lncrime,control=rpart.control(maxdepth=1))
yhat = predict(fit,newdata=list(lncrime=crime.grid)) 

## Fit B stumps on B bootstrapped samples
stump = function(index,b){
  fit = rpart(medv~lncrime,data=Boston,subset=index,
              control=rpart.control(maxdepth=1))
  yhat = predict(fit,newdata=list(lncrime=crime.grid)) 
  lines(crime.grid,yhat,col=mycol[b])
  stump = yhat
}

## Bagging
B = 20
yhat_bag = 0
for (b in 1:B){
  bootsample = sample(n,n,replace=T) 
  yhat_bag = yhat_bag + stump(bootsample,b)/B
}

detach(Boston)
