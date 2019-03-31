###################
## Transportation #
###################
## Code to accompany Lecture on 
## Tree-based Methods
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io

rm(list = ls())
library(nnet)
library(rpart)
library(rpart.plot)
library(ipred)
library(randomForest)
library(gbm)
library(ramify)
source("decisionplot.R")
source("decisionplot_gbm.R")

## reading data
set.seed(100)
transport = read.csv("Transport.txt")
names(transport) = c("loginc","distance","mode")
n = nrow(transport)
train = sample(n,n*0.7) # training sample index
transport_train = transport[train,]
transport_test = transport[-train,]

#######################
# Logistic Regression #
#######################
logitfit <- multinom(mode~.,data=transport_train) 
decisionplot(logitfit,transport_test,class="mode",main="Logistic Regression")

# test err
yhat = predict(logitfit,transport_test) 
err <- 1-mean(yhat==transport_test$mode)
err

#######################
# Classification Tree #
#######################
set.seed(100)
treefit = rpart(mode~.,data=transport_train)
rpart.plot(treefit,box.palette=list("Blues", "Oranges", "Greens"))
decisionplot(treefit,transport_test,class="mode",main="Decision Tree")

# test err
yhat = predict(treefit,transport_test,type="class") 
err <- 1-mean(yhat==transport_test$mode)
err

#################
# Random Forest #
#################
set.seed(100)
rffit = randomForest(mode~.,data=transport_train,mtry=1,maxnodes=4)
decisionplot(rffit,transport_test,class="mode",main="Random Forest")

# test err
yhat = predict(rffit,transport_test) 
err <- 1-mean(yhat==transport_test$mode)
err

############
# Boosting #
############
set.seed(100)
ntree = 500
boostfit = gbm(mode~.,data=transport_train,distribution="multinomial",
               n.trees=ntree,
               interaction.depth = 1,
               shrinkage = 0.001)
decisionplot_gbm(boostfit,transport_test,class="mode",ntree=ntree,main="Boosting")

# test error
fhat = predict(boostfit,transport_test,n.trees=ntree)
fhat = drop(fhat)
yhat = argmax(fhat)
err <- 1-mean(yhat==as.numeric(transport_test$mode))
err
