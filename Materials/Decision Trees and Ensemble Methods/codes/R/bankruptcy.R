###############
## Bankruptcy #
###############
## Code to accompany Lecture on 
## Decision Trees and Ensemble Methods
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io/data-analysis

library(caret)
library(glmnet)
library(rpart)
library(randomForest)
library(nnet)
library(gbm)
rm(list=ls())
data = read.csv("polish.csv") # Polish companies bankruptcy data
data$bankrupt = as.factor(data$bankrupt)
sum(data$class==1)/nrow(data) # bankruptcy rate in data

set.seed(123)
train =  createDataPartition(data$bankrupt,p=0.7,list=F)
data_train = data[train,]
data_test = data[-train,]
ytrue = data_test$bankrupt
sum(data_train$bankrupt==1)/nrow(data_train) # bankruptcy rate in training data
sum(data_test$bankrupt==1)/nrow(data_test) # bankruptcy rate in test data

#######################
# Logistic Regression #
#######################
fit = glm(bankrupt~.,data_train,family="binomial")
summary(fit)

# test err
phat = predict(fit,data_test,type="response")
yhat = as.numeric(phat > 0.5)
table(ytrue,yhat)
1-mean(yhat==ytrue) #misclassification error rate

#######################
# Classification Tree #
#######################
set.seed(100)
fit0 = rpart(bankrupt~.,data_train,control=rpart.control(cp=0))
fit = prune(fit0,cp=fit0$cptable[which.min(fit0$cptable[,"xerror"]),"CP"])

# test err
yhat = predict(fit,data_test,type="class") 
1-mean(yhat==ytrue) #misclassification error rate

#################
# Random Forest #
#################
set.seed(100)
fit = randomForest(bankrupt~.,data=data_train,mtry=43)

############
# Boosting #
############
set.seed(100)
data_boost = transform(data_train,bankrupt=as.numeric(bankrupt)-1) 
ntree = 5000
fit = gbm(bankrupt~.,data_boost, distribution="adaboost",
          n.trees=ntree,interaction.depth=10,shrinkage=0.1)
summary(fit)

# test error
phat = predict(fit,data_test,n.trees=ntree,type="response")
yhat = as.numeric(phat>0.5) 
1-mean(yhat==ytrue)
