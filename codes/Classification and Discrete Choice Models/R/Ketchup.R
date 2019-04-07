############
## Ketchup #
############
## Code to accompany Lecture on 
## Classification
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io

library(mlogit)
rm(list=ls())
set.seed(123)
Ketchup = read.csv("Ketchup.csv")
prop.table(table(Ketchup$choice))
ketchup.long <- mlogit.data(Ketchup, shape="wide", varying = 2:5, choice = "choice")

##########
# Probit #
##########
## Model 1
probitfit1 <- mlogit(choice ~ price|income, ketchup.long, reflevel = "stb", probit=TRUE)
summary(probitfit1)
probitfit1$omega

## Model 2
probitfit2 <- mlogit(choice ~ 0|income|price, ketchup.long, reflevel = "stb", probit=TRUE)
summary(probitfit2)
probitfit2$omega

############
# Logistic #
############
logitfit <- mlogit(choice ~ price|income, ketchup.long, reflevel = "stb")
summary(logitfit)
logitfit$omega

################
# Nested Logit #
################
nlfit = mlogit(choice ~ price|income, ketchup.long, reflevel = "stb",
               nests = list(g1 = c("stb","delmonte"), g2 = c("heinz","hunts")))
summary(nlfit)
nlfit$omega

############################################
# Experiment: 20% price increase for Heinz #
############################################
newdata <- ketchup.long
idx <- index(newdata)$alt == "heinz"
newdata[idx,"price"] <- newdata[idx,"price"]*1.2

logit.phat.new <- predict(logitfit,newdata)
logit.share.new <- colMeans(logit.phat.new)
logit.share.new

probit.phat.new <- predict(probitfit1,newdata)
probit.share.new <- colMeans(probit.phat.new)
probit.share.new
