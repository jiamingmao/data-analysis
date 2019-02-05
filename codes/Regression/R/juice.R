#################
## Orange Juice #
#################
## Code to accompany Lecture on 
## Regression
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io
## credit: Taddy, M. (http://taddylab.com)

rm(list=ls())
oj <- read.csv("oj.csv") 

## visualize
brandcol <- c("green","red","gold")
par(mfrow=c(1,2))
plot(log(price) ~ brand, data=oj, col=brandcol)
plot(logmove ~ log(price), data=oj, col=brandcol[oj$brand])

## regression 1
reg1 = lm(logmove ~ log(price), data=oj)
summary(reg1)

## regression 2
reg2 = lm(logmove ~ log(price)*brand, data=oj)
summary(reg2)

## regression 3
reg3 = lm(logmove ~ log(price)*brand, data=oj)
summary(reg3)