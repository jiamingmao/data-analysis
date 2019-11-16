#################
## Mutual Funds #
#################
## Code to accompany Lecture on 
## Regression
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io
## credit: Gramacy, R. B. (http://bobby.gramacy.com)

library(AER)
rm(list=ls())

mfund <- read.csv("mfunds.csv")
mu <- apply(mfund, 2, mean)
stdev <- apply(mfund, 2, sd)

## run the regression for each of the 6 mutual funds
CAPM <- lm(as.matrix(mfund[,1:6]) ~ mfund$valmrkt)
CAPM

## Windsor regression
reg <- lm(mfund$windsor ~ mfund$valmrkt)
coeftest(reg)
linearHypothesis(reg, "mfund$valmrkt = 1") #hypothesis test. H0: mfund$valmrkt = 1

