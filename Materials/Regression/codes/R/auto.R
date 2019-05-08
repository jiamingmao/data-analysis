#######################
## MPG and Horsepower #
#######################
## Code to accompany Lecture on 
## Regression
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io

library(ISLR)
library(boot)
library(AER)
rm(list=ls())
set.seed(1)

# function to obtain linear regression coefficients of mpg on horsepower
beta <- function(data,index) {
  coef(lm(mpg ~ horsepower,data=data,subset=index))
}

# Bootstrap standard errors
boot(Auto,beta,R=1000)

## Homoskedastic standard errors
coeftest(lm(mpg ~ horsepower,data=Auto))

## Heteroskedasticity-consistent (HC) standard errors
coeftest(lm(mpg ~ horsepower,data=Auto), vcov=vcovHC)
