########
## OLS #
########
## Code to accompany Lecture on 
## Regression
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io/data-analysis

rm(list=ls())
set.seed(5)

## generate data
n <- 500
e <- rnorm(n)
x1 <- runif(n)
x2 <- 0.5*x1 + 0.5*runif(n)
y <- 1 - 2.5*x1 + 5*x2 + e

## regression
reg <- lm(y~x1+x2)
summary(reg)

## manual solution: method 1
X <- cbind(rep(1,n),x1,x2)
beta <- solve(t(X)%*%X)%*%t(X)%*%y
t(beta)

## manual solution: method 2
x1reg <- lm(x1~x2)
u1 <- residuals(x1reg)
b1 <- cov(u1,y)/var(u1)

x2reg <- lm(x2~x1)
u2 <- residuals(x2reg)
b2 <- cov(u2,y)/var(u2)

b0 = mean(y) - b1*mean(x1) - b2*mean(x2)
cbind(b0,b1,b2)
