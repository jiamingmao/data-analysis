###################
## Transportation #
###################
## Code to accompany Lecture on 
## Classification and Discrete Choice Models
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io/data-analysis/

library(mlogit)
set.seed(123)

## reading data
rm(list = ls())
transport <- read.csv("Transport.txt")
colnames(transport) <- c("loginc", "distance","y")
prop.table(table(transport$y))
transport.long <- mlogit.data(transport, shape="wide", choice="y")

#######################
# Logistic Regression #
#######################
logitfit <- mlogit(y ~ 0|loginc + distance, transport.long)
summary(logitfit)

##########
# Probit #
##########
probitfit <- mlogit(y ~ 0|loginc + distance, transport.long, probit=TRUE)
summary(probitfit)

#########################
# Experiment: No Subway #
#########################
## counterfactual data 
newdata <- transport.long
idx <- index(newdata)$alt == "subway"
newdata[idx,"loginc"] <- -1e10 #make P(subway) = 0
newdata[idx,"distance"] <- -1e10 #make P(subway) = 0

## counterfactual market share
# logistic
logit.phat.new <- predict(logitfit,newdata)
logit.share.new <- colMeans(logit.phat.new)
logit.share.new
# probit
probit.phat.new <- predict(probitfit,newdata)
probit.share.new <- colMeans(probit.phat.new)
probit.share.new