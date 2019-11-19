#########################
## Post-Lasso Inference #
#########################
## Code to accompany Lecture on 
## Model Selection and Regularization
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io/data-analysis/

rm(list=ls())
set.seed(4) 

# Simulation
n = 100 # sample size
p = 99 # number of variables
s = 5 # number of variables witn non-zero coefficients
X = matrix(rnorm(n*p),ncol=p)
beta = c(rep(5,s),rep(0,p-s))
Y = X%*%beta + rnorm(n)

# Lasso
require(glmnet)
cv.lasso = cv.glmnet(X,Y,intercept=FALSE)
lambda.star = cv.lasso$lambda.min
fit.lasso = glmnet(X,Y,intercept=FALSE,lambda=lambda.star)

# Post-lasso OLS
chosen.var = X[,which(fit.lasso$beta!= 0)] 
fit.olslasso = lm(Y ~ chosen.var-1)
pv.naive = summary(fit.olslasso)$coefficients[,4]

# Selective Inference
require(selectiveInference)
lassoInf = fixedLassoInf(X,Y,
                         beta=fit.lasso$beta,
                         lambda=fit.lasso$lambda)
pv.lasso = lassoInf$pv
