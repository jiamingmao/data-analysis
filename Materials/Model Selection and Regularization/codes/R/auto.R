#########
## Auto #
#########
## Code to accompany Lecture on 
## Model Selection and Regularization
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io/data-analysis

library(ISLR)
library(boot)
library(AER)
rm(list=ls())
set.seed(1)

attach(Auto) #require("ISLR")
n <- nrow(Auto)

###########################
# Validation Set Approach #
###########################
train <- sample(392,196) #generate training set
V.MSE <- rep(0,5)
for (k in 1:5){
  fit <- lm(mpg ~ poly(horsepower,k), subset=train) #polynomial regression up to the power k
  validation.e <- (mpg - predict(fit,Auto))[-train] #validation set error
  V.MSE[k] <- mean(validation.e^2) #validation set MSE
}
V.MSE

#########
# LOOCV #
#########
LOOCV.MSE = rep(0,5)
for (k in 1:5){
  fit <- glm(mpg ~ poly(horsepower,k))
  LOOCV.MSE[k] <- cv.glm(Auto,fit)$delta[1] #require("boot")
}
LOOCV.MSE

##############
# 10-fold CV #
##############
CV.MSE = rep(0,5)
for (k in 1:5){
  fit <- glm(mpg ~ poly(horsepower,k))
  CV.MSE[k] <- cv.glm(Auto,fit,K=10)$delta[1] 
}
CV.MSE

########################
# Information Criteria #
########################
all.AIC = rep(0,5)
all.BIC = rep(0,5)
for (k in 1:5){
  fit <- glm(mpg ~ poly(horsepower,k))
  all.AIC[k] <- AIC(fit)
  all.BIC[k] <- BIC(fit)
}
cbind(all.AIC,all.BIC)

detach(Auto)

