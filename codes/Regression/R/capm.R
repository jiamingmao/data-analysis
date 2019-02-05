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

## plot mean-std graph
plot(mu, stdev, col=0, cex.lab=1.25) ## create an empty plot with the right limits
text(x=mu, y=stdev, labels=names(mfund), col="brown")

## run the regression for each of the 6 mutual funds
CAPM <- lm(as.matrix(mfund[,1:6]) ~ mfund$valmrkt)
CAPM

## plot alpha-beta graph
plot(CAPM$coeff[2,], CAPM$coeff[1,],
     ylab="alpha", xlab="beta", col=0, xlim=c(.3,1.6), cex.lab=1.25)
text(x=CAPM$coeff[2,], y=CAPM$coeff[1,], 
     labels=names(mfund)[1:6], col="brown")

## looking just at Windsor 
plot(mfund$valmrkt, mfund$windsor, pch=20, col="cornflowerblue")

## Windsor regression
reg <- lm(mfund$windsor ~ mfund$valmrkt)
coeftest(reg)
linearHypothesis(reg, "mfund$valmrkt = 1") #hypothesis test. H0: mfund$valmrkt = 1

