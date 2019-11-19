#################
## Orange Juice #
#################
## Code to accompany Lecture on 
## Regression
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io/data-analysis/
## credit: Taddy, M. (http://taddylab.com)

rm(list=ls())
oj <- read.csv("oj.csv") 

## regression 1
reg1 = lm(logmove ~ log(price), data=oj)
summary(reg1)

## regression 2
reg2 = lm(logmove ~ log(price)*brand, data=oj)
summary(reg2)

## regression 3
reg3 = lm(logmove ~ log(price)*brand, data=oj)
summary(reg3)