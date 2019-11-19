########################
## Credit Card Balance #
########################
## Code to accompany Lecture on 
## Model Selection and Regularization
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io/data-analysis

library(leaps)
library(glmnet)
rm(list = ls())
credit <- read.csv("Credit.csv")
n <- nrow(credit)
set.seed(123)

# Fit the entire model with all potential predictors
fit <- lm(Balance~., credit)
summary(fit)

#########################
# Best Subset Selection # 
#########################
all.fit <- regsubsets(Balance~., credit) #require("leaps")
all <- summary(all.fit)
all$outmat
all$cp 
all$bic

#####################
# Forward Selection # 
#####################
null = lm(Balance ~ 1, credit)
full = lm(Balance ~., credit)

# Forward stepwise selection using AIC
fwd.AIC = step(null, scope = formula(full), direction="forward")
summary(fwd.AIC)

# Forward stepwise selection using BIC
fwd.BIC = step(null, scope = formula(full), direction="forward", k=log(n))
summary(fwd.BIC)

####################
# Ridge Regression # 
####################
x <- model.matrix(Balance ~.,credit)[,-1] #no intercept 
y <- credit$Balance
ridgefit <- glmnet(x,y,alpha=0,lambda=0.01) 
coef(ridgefit)
ridgefit <- glmnet(x,y,alpha=0,lambda=10000) 
coef(ridgefit)
ridgefit <- glmnet(x,y,alpha=0) #fit a range of lambda
ridgefit$lambda # see the lambda's that are being fit
dim(coef(ridgefit)) #coef(ridgefit) is a matrix with p rows (number of coefficents)
                    #and number of columns = number of lambda's (automatically selected)   

# Coefficient Plot
plot(ridgefit,xvar="lambda")

# Cross-validation
cv.out <- cv.glmnet(x,y,alpha=0) #default is 10-fold CV
coef(cv.out,s="lambda.min") #coefficient estimates using min lambda 
coef(cv.out) #default is using lambda according to the 1se rule
             #Equivalently, coef(cv.out,s="lambda.1se")

# CV Plot
plot(cv.out)

# Refit the model using the best lambda according to CV results
bestlam <- cv.out$lambda.min #min lambda 
ridgefit <- glmnet(x,y,alpha=0,lambda=bestlam) 
coef(ridgefit) #this result should be very close to coef(cv.out,s="lambda.min")

#########
# Lasso #
#########
lassofit <- glmnet(x,y,alpha=1) #fit a range of lambda

# Coefficient Plot
plot(lassofit,xvar="lambda")

# Cross-validation
cv.out <- cv.glmnet(x,y,alpha=1)
coef(cv.out,s="lambda.min")
coef(cv.out) #Equivalently, coef(cv.out,s="lambda.1se")

# CV Plot
plot(cv.out)

# Refit the model using the best lambda according to CV results
bestlam <- cv.out$lambda.min #min lambda 
lassofit <- glmnet(x,y,alpha=1,lambda=bestlam) 
coef(lassofit) #this result should be very close to coef(cv.out,s="lambda.min")

# Alternatively, use the 1se rule:
bestlam <- cv.out$lambda.1se #lambda according to the 1se rule
lassofit <- glmnet(x,y,alpha=1,lambda=bestlam) 
coef(lassofit) #this result should be very close to coef(cv.out,s="lambda.1se")

