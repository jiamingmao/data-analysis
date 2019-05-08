################
## Elastic Net #
################
## Code to accompany Lecture on 
## Model Selection and Regularization
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io

library(MASS)
library(glmnet)
rm(list=ls())
set.seed(123)
n = 100
z1 = rnorm(n)
z2 = rnorm(n)
e = mvrnorm(n,mu=rep(0,7),Sigma=diag(7))
x1 = z1 + e[,2:4]/5
x2 = z2 + e[,5:7]/5
x = cbind(x1,x2)
y = 3*z1 - 1.5*z2 + 2*e[,1]

# lasso
lassofit = glmnet(x,y,alpha=1)
plot(lassofit,xvar="lambda")

# elastic net
enetfit = glmnet(x,y,alpha=0.3)
plot(enetfit,xvar="lambda")