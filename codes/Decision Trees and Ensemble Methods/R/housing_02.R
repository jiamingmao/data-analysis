##########################
## Boston Housing Prices #
##########################
## Code to accompany Lecture on 
## Tree-based Methods
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io

library(MASS)
library(corrplot)
library(caret)
library(rpart)
library(rpart.plot)
library(tree)
library(randomForest)
library(gbm)
rm(list=ls())
head(Boston)
corrplot(cor(Boston)) # visualize correlation matrix 

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
plot(yhat,ytrue)
abline(0,1)
mean((yhat-ytrue)^2)

###################
# Regression Tree #
###################
set.seed(100)
fit0 = rpart(medv~.,data_train,
             control=rpart.control(cp=0,minbucket=2))
printcp(fit0)
plotcp(fit0)

# prune
fit = prune(fit0,cp=fit0$cptable[which.min(fit0$cptable[,"xerror"]),"CP"])

# visualize
rpart.plot(fit,extra=1,box.palette="Oranges")

# test error
yhat = predict(fit,data_test) 
plot(yhat,ytrue)
abline(0,1)
mean((yhat-ytrue)^2)

###########
# Bagging #
###########
set.seed(100)
fit = randomForest(medv~.,data_train,mtry=13,importance =TRUE)

# test error
yhat = predict(fit,data_test) 
plot(yhat,ytrue)
abline(0,1)
mean((yhat-ytrue)^2)

#################
# Random Forest #
#################
set.seed(100)
fit = randomForest(medv~.,data_train,mtry=5,importance =TRUE)

# variable importance and partial dependence plots
varImpPlot(fit)
partialPlot(fit,data_train,rm)
partialPlot(fit,data_train,lstat)

# test error
yhat = predict(fit,data_test) 
plot(yhat,ytrue)
abline(0,1)
mean((yhat-ytrue)^2)

############
# Boosting #
############
set.seed(100)
fit = gbm(medv~.,data=data_train, distribution="gaussian",
          n.trees=10000,interaction.depth=5,shrinkage=0.001)
summary(fit)
plot(fit,i="rm")
plot(fit,i="lstat")

# test error
yhat = predict(fit,data_test,n.trees=10000) 
plot(yhat,ytrue)
abline(0,1)
mean((yhat-ytrue)^2)
