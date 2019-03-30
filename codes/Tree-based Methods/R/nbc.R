##############
## NBC Shows #
##############
## Code to accompany Lecture on 
## Tree-based Methods
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io
## Credit: M. Taddy (http://taddylab.com/)

library(tree)
library(nnet)
rm(list=ls())
nbc <- read.csv("nbc_showdetails.csv") 
demo <- read.csv("nbc_demographics.csv")
demo <- demo[,-1]
y <- nbc$Genre

###################################
# Multinomial Logistic Regression #
###################################
logitfit <- multinom(y~.,demo)
summary(logitfit)

#######################
# Classification Tree #
#######################
set.seed(50)
t0 <- tree(y~.,demo,mincut=1)
summary(t0)
plot(t0)
text(t0)

# CV
cvt = cv.tree(t0,FUN=prune.misclass) #use misclassification rate for pruning
plot(cvt$size,cvt$dev,type="b")

# Pruning
t1 = prune.misclass(t0,best=cvt$size[which.min(cvt$dev)])
plot(t1)
text(t1)

