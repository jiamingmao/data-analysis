##################
## U.S. Election #
##################
## Code to accompany Lecture on 
## Model Selection and Regularization
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io/data-analysis

rm(list=ls())
set.seed(50)
gss <- read.csv("GSS2018.csv")
names(gss)
summary(gss$pres16)

####################
# Lasso Regression #
####################

require(glmnet)
X = model.matrix(pres16 ~.,gss)[,-1]
Y = gss$pres16

# fit the lasso with a range of automatically selected lambdas
lasso.all = glmnet(X,Y,alpha=1,family="binomial")
plot(lasso.all,xvar="lambda")

# cross-validation
cv.lasso = cv.glmnet(X,Y,alpha=1,family="binomial")
plot(cv.lasso)

# choose lambda associated with min CV error (or plus 1se)
lambda.star = cv.lasso$lambda.1se # Alternatively: cv.lasso$lambda.min

# fit the lasso with optimal lambda
fit = glmnet(X,Y,alpha=1,lambda=lambda.star,family="binomial")


