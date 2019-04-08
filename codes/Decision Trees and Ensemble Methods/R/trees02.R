##########
## Trees #
##########
## Code to accompany Lecture on 
## Tree-based Methods
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io

rm(list=ls())
library(nnet)
library(rpart)
library(rpart.plot)
library(randomForest)
library(gbm)
library(caret)
library(AER)

# Simulation
set.seed (100)
n = 1000
x = matrix(rnorm(n*2),ncol=2)
x[1:n/2,]=x[1:n/2,]+2
x[(n/2+1):(n/4*3),]= x[(n/2+1):(n/4*3),]-2
y=c(rep(1,(n/4*3)),rep(2,(n/4)))

# create training and test set
data = data.frame(x1=x[,1],x2=x[,2],y=as.factor(y))
train = sample(n,n*0.4)
data_train = data[train,]
data_test = data[-train,]
ytrue = data_test[,"y"]
plot(data_train$x1,data_train$x2,col=data_train$y)

###############################
# Logistic Regression: Linear #
###############################
fit = multinom(y~.,data=data_train) 
coeftest(fit)

# test err
yhat = predict(fit,data_test) 
table(ytrue,yhat)

##################################
# Logistic Regression: Quadratic #
##################################
fit = multinom(y~poly(x1,2)+poly(x2,2),data=data_train) 
coeftest(fit)

# test err
yhat = predict(fit,data_test) 
table(ytrue,yhat)
err = 1-mean(yhat==ytrue)
err

#######################
# Classification Tree #
#######################
set.seed(100)
fit0 = rpart(y~.,data_train,control=rpart.control(cp=0))
fit = prune(fit0,cp=fit0$cptable[which.min(fit0$cptable[,"xerror"]),"CP"])

# test err
yhat = predict(fit,data_test,type="class") 
err <- 1-mean(yhat==ytrue)
err

#################
# Random Forest #
#################
set.seed(100)
fit = randomForest(y~.,data=data_train,mtry=1,maxnodes=10)

# test err
yhat = predict(fit,data_test) 
err <- 1-mean(yhat==ytrue)
err

############
# Boosting #
############
set.seed(100)
fit = train(y~., data=data_train, method="gbm",distribution="adaboost",
            tuneGrid=expand.grid(n.trees=c(500,1000,5000),
                                 interaction.depth=seq(1:10),
                                 n.minobsinnode=1,
                                 shrinkage=c(0.001,0.01)),
            trControl=trainControl(method="repeatedcv",repeats=3))
fit$bestTune
plot(fit)
#
# test error
yhat = predict(fit,data_test)
err <- 1-mean(yhat==ytrue)
err