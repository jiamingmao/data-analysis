#####################
## Multistage Lasso #
#####################
## Code to accompany Lecture on 
## Model Selection and Regularization
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io/data-analysis/

rm(list=ls())
set.seed(4) 

# Training Set
n = 100 # sample size
p = 99 # number of variables
s = 5 # number of variables witn non-zero coefficients
X = matrix(rnorm(n*p),ncol=p)
beta = c(rep(5,s),rep(0,p-s))
Y = X%*%beta + rnorm(n)

# Test set 
nn = 1e5 # testset size
Xnew = matrix(rnorm(nn*p), ncol=p)
Ynew = Xnew%*%beta + rnorm(nn) 

#######
# OLS #
#######
fit.ols = lm(Y ~ X-1) 

# number of non-zero coefs
sum(fit.ols$coefficients!=0)

# number of significant vars
pv.ols = summary(fit.ols)$coefficients[,4]
sum(pv.ols<.05)

pred.ols = predict(fit.ols,data.frame(X=Xnew))
err.ols = mean((Ynew - pred.ols)^2)

#########
# LASSO #
#########
require(glmnet)
lasso.all = glmnet(X,Y,intercept=FALSE)
plot(lasso.all)

cv.lasso = cv.glmnet(X,Y,intercept=FALSE)
lambda.star = cv.lasso$lambda.min
fit.lasso = glmnet(X,Y,intercept=FALSE,lambda=lambda.star)

sum(fit.lasso$beta!=0)

pred.lasso = predict(fit.lasso,Xnew)
err.lasso = mean((Ynew - pred.lasso)^2)

#################
# Relaxed Lasso #
#################
require(relaxo)
fit.relaxo = cvrelaxo(X,Y)

sum(fit.relaxo$beta!=0)

pred.relaxo = predict(fit.relaxo,Xnew)
err.relaxo = mean((Ynew - pred.relaxo)^2)

