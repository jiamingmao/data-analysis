################
## Supermarket #
################
## Code to accompany Lecture on 
## Model Selection and Regularization
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io

library(ISLR)
library(glmnet)
library(caret)
rm(list = ls())
set.seed(123)

supermarket <- read.csv("Supermarket.csv")
supermarket$entry <- factor(supermarket$entry,levels=c(0,1),labels=c("FALSE","TRUE"))
summary(supermarket)

# Split into training and test data sets
n <- nrow(supermarket)
train <- sample(n,n/2)
supermarket.tr <- supermarket[train,]
supermarket.te <- supermarket[-train,]

###################################
# Logistic Regression: Full Model #
###################################
# Fit on training data
logitfit <- glm(entry ~.,supermarket.tr,family='binomial')
summary(logitfit)

# Predict on test data
p = predict(logitfit,supermarket.te,type="response")
logitpred = as.factor(p > 0.5)
table(logitpred,supermarket.te$entry,dnn=c("predicted","true"))
logiterr <- 1-mean(logitpred==supermarket.te$entry) #misclassification error rate
logiterr

##############################
# Logistic Regression: Lasso #
##############################
# Fit on training data
x <- model.matrix(entry ~.,supermarket.tr)[,-1] #no intercept 
y <- supermarket.tr$entry
lassofit.all <- glmnet(x,y,alpha=1,family="binomial") 
plot(lassofit.all,xvar="lambda")

# Cross Validation
cv.lasso <- cv.glmnet(x,y,alpha=1,family="binomial") 
plot(cv.lasso)

# Refit the model using optimal lambda 
lambda.star <- cv.lasso$lambda.min #alternatively, use the 1se rule: lambda.star <- cv.lasso$lambda.1se
lassofit.star <- glmnet(x,y,alpha=1,lambda=lambda.star,family="binomial") 
coef(lassofit.star)

# Predict on test data
newx <- model.matrix(entry ~.,supermarket.te)[,-1] 
lassopred <- predict(lassofit.star,newx,type="class")
table(lassopred,supermarket.te$entry,dnn=c("predicted","true"))
lassoerr <- 1-mean(lassopred==supermarket.te$entry)
lassoerr

#######
# KNN #
#######
# Fit on training data
knnfit <- train(entry ~.,data=supermarket.tr,method="knn",             #require("caret")
                trControl=trainControl(method="repeatedcv",repeats=3), #use repeated CV to choose K
                preProcess=c("center","scale"),tuneLength = 50)        #center and scale predictors before KNN
plot(knnfit)

# Predict on test data
knnpred <- predict(knnfit,supermarket.te)
table(knnpred,supermarket.te$entry,dnn=c("predicted","true"))
knnerr <- 1-mean(knnpred==supermarket.te$entry)
knnerr

