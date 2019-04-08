################
## Supermarket #
################
## Code to accompany Lecture on 
## Neural Networks
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io

library(caret)
library(glmnet)
library(corrplot)
library(rpart)
library(rpart.plot)
library(randomForest)
library(gbm)
library(e1071)
library(nnet)
library(neuralnet)
library(NeuralNetTools)
library(gridExtra)
rm(list=ls())
data = read.csv("supermarket_entry.csv") 
summary(data)
corrplot(cor(data))

# process
data[,1:24] = scale(data[,1:24]) # scale the data
data$entry = as.factor(data$entry)
nvar = ncol(data) - 1

# create training and test sets
set.seed(123)
train =  createDataPartition(data$entry,p=0.5,list=F)
data_train = data[train,]
data_test = data[-train,]
ytrue = data_test$entry

#######################
# Logistic Regression #
#######################
fit <- glm(entry ~.,data_train,family='binomial')
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
fit = rpart(entry ~.,data_train)
rpart.plot(fit,box.palette=list("Grays", "Reds"))

# test err
yhat = predict(fit,data_test,type="class") 
table(ytrue,yhat)
1-mean(yhat==ytrue) #misclassification error rate

#################
# Random Forest #
#################
set.seed(100)
fit = randomForest(entry ~.,data=data_train,mtry=6)

# test err
yhat = predict(fit,data_test) 
table(ytrue,yhat)
1-mean(yhat==ytrue) #misclassification error rate

############
# Boosting #
############
set.seed(100)
ntree = 2000
data_boost = transform(data_train,entry=as.numeric(entry)-1)
fit = gbm(entry~.,data_boost,distribution="adaboost",
          n.trees=ntree,
          interaction.depth = 10,
          shrinkage = 0.01)

# test error
phat = predict(fit,data_test,n.trees=ntree,type="response")
yhat = as.numeric(phat>0.5) 
table(ytrue,yhat)
1-mean(yhat==ytrue)

#######
# SVM #
#######
set.seed (100)
fit= svm(entry~.,data_train,kernel="radial",gamma=0.01,cost=30,scale=F)
yhat = predict(fit,data_test,type="class") 
table(ytrue,yhat)
1-mean(yhat==ytrue) #misclassification error rate

##############
# Neural Net #
##############
set.seed(100)
fit = nnet(entry ~.,data=data_train,
           size=10,maxit=10000,MaxNWts=10000,decay=0.1)

# test err 
yhat = predict(fit,data_test,type="class") 
table(ytrue,yhat)
1-mean(yhat==ytrue) #misclassification error rate

# visualize results
# vidualize network
plotnet(fit,alpha_val=.2,
        circle_col="hotpink",
        pos_col="burlywood",
        neg_col="darkgray")

# importance plots based on weights 
h = olden(fit)
h + coord_flip() + theme(axis.text=element_text(size=14),axis.title=element_text(size=14))

# partial dependence plots of selected vars (other vars fixed at median)
h1 = lekprofile(fit,xsel=c("pop"),group_vals=0.5) + 
  theme(legend.position="none",axis.title=element_blank())
h2 = lekprofile(fit,xsel=c("meanincome"),group_vals=0.5) + 
  theme(legend.position="none",axis.title=element_blank())
h3 = lekprofile(fit,xsel=c("unemp"),group_vals=0.5) + 
  theme(legend.position="none",axis.title=element_blank())
h4 = lekprofile(fit,xsel=c("crime"),group_vals=0.5) + 
  theme(legend.position="none",axis.title=element_blank())
grid.arrange(h1,h2,h3,h4,ncol=2)
