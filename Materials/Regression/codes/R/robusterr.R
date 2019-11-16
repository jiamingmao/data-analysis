###########################
## Robust Standard Errors #
###########################
## Code to accompany Lecture on 
## Regression
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io

library(AER)
rm(list=ls())
set.seed(5)

## generate data
n <- 1e3
x <- 100*runif(n)
y <- rnorm(n,mean=5*x, sd=exp(x))

## regression
r = lm(y~x)

## compare heteroskedasticity-consistent (HC) standard errors 
## with simple standard errors based on homoskedasticity assumption
coeftest(r)
coeftest(r, vcov = vcovHC)
