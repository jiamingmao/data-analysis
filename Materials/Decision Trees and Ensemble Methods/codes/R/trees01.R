##########
## Trees #
##########
## Code to accompany Lecture on 
## Decision Trees and Ensemble Methods
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io/data-analysis

rm(list=ls())
library(nnet)
library(rpart)
library(rpart.plot)
library(randomForest)
library(gbm)
library(caret)
library(AER)

# Simulation
set.seed (10)
n = 1000
x = matrix(rnorm(n*2),ncol=2)
z = 2*x[,1] + 2*x[,2] 
p = exp(z)/(1+exp(z)) #p(y=1)
u = runif(n)
y = (p>u) 

# create training and test set
data = data.frame(x1=x[,1],x2=x[,2],y=as.factor(y))
train = sample(n,n*0.4)
data_train = data[train,]
data_test = data[-train,]
ytrue = data_test[,"y"]

#######################
# Logistic Regression #
#######################
set.seed(100)
fit = multinom(y~.,data=data_train) 
coeftest(fit)

# test err
yhat = predict(fit,data_test) 
err = 1-mean(ytrue==yhat)
err

#######################
# Classification Tree #
#######################
set.seed(100)
fit0 = rpart(y~.,data_train,control=rpart.control(cp=0))
fit = prune(fit0,cp=fit0$cptable[which.min(fit0$cptable[,"xerror"]),"CP"])
rpart.plot(fit,box.palette=c("Reds","Greens"))

# test err
yhat = predict(fit,data_test,type="class") 
err = 1-mean(ytrue==yhat)
err

###########
# Bagging #
###########
set.seed(100)
fit = randomForest(y~.,data=data_train,mtry=2,maxnodes=8)

# test err
yhat = predict(fit,data_test) 
err = 1-mean(ytrue==yhat)
err

############
# Boosting #
############
set.seed(100)
ntree = 4000
data_boost = transform(data_train, y = as.numeric(y) - 1)
fit = gbm(y~.,data=data_boost,distribution="adaboost",
          n.trees=ntree,
          interaction.depth = 2,
          shrinkage = 0.001)

# test error
phat = predict(fit,data_test,n.trees=ntree,type="response")
yhat = (phat>0.5) 
err = 1-mean(yhat==ytrue)
err