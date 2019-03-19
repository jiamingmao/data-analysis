##############
## Bootstrap #
##############
## Code to accompany Lecture on 
## Regression
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io

library(ISLR)
library(boot)
rm(list=ls())
set.seed(123)

## "Portfolio" is a data set in ISLR containing the returns of two assets: X and Y
## alpha is the min variance a portfolio of X and Y can achieve

# function to calcualte alpha
alpha=function(data,index){
  X=data$X[index]
  Y=data$Y[index]
  return((var(Y)-cov(X,Y))/(var(X)+var(Y)-2*cov(X,Y)))
}

n <- nrow(Portfolio)
bootsample <- sample(n,n,replace=T) # generate one bootstrap sample
alpha(Portfolio,bootsample) # calculate alpha based on this bootstrap sample

# Bootstrap
boot(Portfolio,alpha,R=1000) # calculate alpha based on 1000 bootstrap samples

# ------ we can do bootstrap in parallel -----
boot(Portfolio,alpha,R=B, parallel="multicore")

# ------ we can also do bootstrap manually -----
B = 1000 # number of bootstrap samples 
A = numeric(B)
for(i in 1:B) {
  A[i] <- alpha(Portfolio,sample(n,n,replace=T))
}
mean(A)
sd(A)
