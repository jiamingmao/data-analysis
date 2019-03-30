##########################
## Boston Housing Prices #
##########################
## Code to accompany Lecture on 
## Tree-based Methods
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io

library(MASS)
library(caret)
library(rpart)
library(rpart.plot)
library(tree)
library(randomForest)
library(gbm)
rm(list=ls())
head(Boston)

set.seed(100)
train = sample(nrow(Boston), nrow(Boston)*0.7) #training sample idx

#################
# Decision Tree #
#################
set.seed(100)
fit0 = rpart(medv~.,data=Boston,subset=train,
             control=rpart.control(cp=0,minbucket=2))
printcp(fit0)
plotcp(fit0)

fit = prune(fit0,cp=fit0$cptable[which.min(fit0$cptable[,"xerror"]),"CP"])
rpart.plot(fit,extra=1,box.palette="Oranges")

# test error
y = Boston[-train,"medv"] #true medv on test data
yhat = predict(fit,newdata=Boston[-train,]) #predicted medv
plot(yhat,y)
abline(0,1)
testErr = mean((yhat-y)^2)
testErr

###########
# Bagging #
###########
set.seed(100)
fit = randomForest(medv~.,data=Boston,subset=train,mtry=13,importance =TRUE)
fit
varImpPlot(fit)
partialPlot(fit, Boston[train,],rm)
partialPlot(fit, Boston[train,],lstat)

# test error
yhat = predict(fit,newdata=Boston[-train,]) #predicted medv
plot(yhat,y)
abline(0,1)
testErr = mean((yhat-y)^2)
testErr

#################
# Random Forest #
#################
set.seed(100)
fit = randomForest(medv~.,data=Boston,subset=train,mtry=5,importance =TRUE)
fit
varImpPlot(fit)
partialPlot(fit, Boston[train,],rm)
partialPlot(fit, Boston[train,],lstat)

# test error
yhat = predict(fit,newdata=Boston[-train,]) #predicted medv
plot(yhat,y)
abline(0,1)
testErr = mean((yhat-y)^2)
testErr

############
# Boosting #
############
set.seed(100)
fit = gbm(medv~.,data=Boston[train,], distribution="gaussian",
          n.trees=5000,interaction.depth=5,shrinkage=0.001)
summary(fit)
plot(fit,i="rm")
plot(fit,i="lstat")

# test error
yhat = predict(fit,newdata=Boston[-train,],n.trees=5000) #predicted medv
plot(yhat,y)
abline(0,1)
testErr = mean((yhat-y)^2)
testErr
