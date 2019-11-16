###########
## Voting #
###########
## Code to accompany Lecture on 
## Classification and Discrete Choice Models
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io/data-analysis/

library(gmodels)

## reading data
rm(list = ls())
voting <- read.csv("voting.txt")
attach(voting)

######################
## Linear Regression #
######################
lsfit <- lm(vote~income)
summary(lsfit)

# prediction on training data
ls.p <- lsfit$fit
lsvote <- as.numeric(ls.p > .5)
CrossTable(lsvote,vote,digits=2,prop.r=FALSE,prop.t=FALSE,prop.chisq=FALSE,
           dnn=c("LS predicted vote","true vote"),format="SPSS")

########################
## Logistic Regression #
########################
logitfit <- glm(vote~income,family=binomial)
summary(logitfit)

# prediction on training data
logit.p <- logitfit$fit
logitvote <- as.numeric(logit.p > .5)
CrossTable(logitvote,vote,digits=2,prop.r=FALSE,prop.t=FALSE,prop.chisq=FALSE,
           dnn=c("Logistic predicted vote","true vote"),format="SPSS")

###########
## Probit #
###########
probitfit <- glm(vote~income,family = binomial(link = "probit"))
summary(probitfit)

#
detach(voting)
