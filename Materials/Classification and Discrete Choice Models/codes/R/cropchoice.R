################
## Crop Choice #
################
## Code to accompany Lecture on 
## Classification and Discrete Choice Models
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io/data-analysis/

## reading data
rm(list = ls())
cropchoice <- read.csv("cropchoice.txt")
attach(cropchoice)
crops <- as.matrix(cropchoice[,4:7])

## Logistic
require(nnet)
logitfit <- multinom(crops ~ temperature + rainfall)
summary(logitfit)

## Linear Regression 
p <- crops/fields
eps <- 1e-4
p[p==0] = p[p==0] + eps

z.corn = log(p[,2]) - log(p[,1])
lsfit.corn <- lm(z.corn ~ temperature + rainfall)
summary(lsfit.corn)

z.wheat = log(p[,3]) - log(p[,1])
lsfit.wheat <- lm(z.wheat ~ temperature + rainfall)
summary(lsfit.wheat)

z.rice = log(p[,4]) - log(p[,1])
lsfit.rice <- lm(z.rice ~ temperature + rainfall)
summary(lsfit.rice)

## prediction
xtemp = pretty(temperature, 20)
xrain = pretty(rainfall, 20)
XX <- expand.grid(temperature=xtemp,rainfall=xrain)
logit.crops <- predict(logitfit,XX,type="probs")

#
detach(cropchoice)