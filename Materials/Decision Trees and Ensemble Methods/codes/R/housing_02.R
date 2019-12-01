##########################
## Boston Housing Prices #
##########################
## Code to accompany Lecture on 
## Decision Trees and Ensemble Methods
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io/data-analysis

library(MASS)
library(caret)
library(rpart)
library(tree)
library(randomForest)
library(gbm)
rm(list=ls())
head(Boston)

set.seed(100)
train = sample(nrow(Boston), nrow(Boston)*0.6) 
data_train = Boston[train,]
data_test = Boston[-train,]
ytrue = data_test[,"medv"] #true medv on test data

#####################
# Linear Regression #
#####################
fit = lm(medv~.,data_train)
summary(fit)

# test error
yhat = predict(fit,data_test) 
mean((yhat-ytrue)^2)

###################
# Regression Tree #
###################
set.seed(100)
fit0 = rpart(medv~.,data_train,
             control=rpart.control(cp=0,minbucket=2))
printcp(fit0)

# prune
fit = prune(fit0,cp=fit0$cptable[which.min(fit0$cptable[,"xerror"]),"CP"])

# test error
yhat = predict(fit,data_test) 
mean((yhat-ytrue)^2)

###########
# Bagging #
###########
set.seed(100)
fit = randomForest(medv~.,data_train,mtry=13,importance =TRUE)

# test error
yhat = predict(fit,data_test) 
mean((yhat-ytrue)^2)

#################
# Random Forest #
#################
set.seed(100)
fit = randomForest(medv~.,data_train,mtry=5,importance =TRUE)

# test error
yhat = predict(fit,data_test) 
mean((yhat-ytrue)^2)

############
# Boosting #
############
set.seed(100)
fit = gbm(medv~.,data=data_train, distribution="gaussian",
          n.trees=10000,interaction.depth=5,shrinkage=0.001)
summary(fit)

# test error
yhat = predict(fit,data_test,n.trees=10000) 
mean((yhat-ytrue)^2)
