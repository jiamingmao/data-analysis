#############
## Anscombe #
#############
## Code to accompany Lecture on 
## Regression
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io
## credit: Gramacy, R. B. (http://bobby.gramacy.com)

rm(list=ls())

## read and summarize data
attach(anscombe <- read.csv("anscombe.csv"))
c(x.m1=mean(x1), x.m2=mean(x2), x.m3=mean(x3), x.m4=mean(x4))
c(y.m1=mean(y1), y.m2=mean(y2), y.m3=mean(y3), y.m4=mean(y4))
c(x.sd1=sd(x1), x.sd2=sd(x2), x.sd3=sd(x3), x.sd3=sd(x4))
c(y.sd1=sd(y1), y.sd2=sd(y2), y.sd4=sd(y3), y.sd4=sd(y4))
c(cor1=cor(x1,y1), cor2=cor(x2,y2), cor3=cor(x3,y3), cor4=cor(x4,y4))

## visualize
par(mfrow=c(2,2), mai=c(.7,.7,.1,.1))
plot(x1,y1, col=1, pch=20, cex=1.5)
plot(x2,y2, col=2, pch=20, cex=1.5)
plot(x3,y3, col=3, pch=20, cex=1.5)
plot(x4,y4, col=4, pch=20, cex=1.5)

## regression
reg <- list(reg1=lm(y1~x1), reg2=lm(y2~x2),reg3=lm(y3~x3), reg4=lm(y4~x4))
attach(reg)
cbind(reg1$coef, reg2$coef, reg3$coef, reg4$coef)
s <- lapply(reg, summary) ## apply the function summary to each element of the list
c(s$reg1$r.sq, s$reg2$r.sq,s$reg3$r.sq, s$reg4$r.sq)

## plot with the regression lines
par(mfrow=c(2,2), mai=c(.7,.7,.1,.1))
plot(x1,y1, col=1, pch=20, cex=1.5)
abline(reg1, col=1)
plot(x2,y2, col=2, pch=20, cex=1.5)
abline(reg2, col=2)
plot(x3,y3, col=3, pch=20, cex=1.5)
abline(reg3, col=3)
plot(x4,y4, col=4, pch=20, cex=1.5)
abline(reg4, col=4)

# plot fitted values against residuals
par(mfrow=c(2,2), mai=c(.7,.7,.1,.1))
plot(reg1$fitted,reg1$residuals, col=1, pch=20, cex=1.5)
plot(reg2$fitted,reg2$residuals, col=2, pch=20, cex=1.5)
plot(reg3$fitted,reg3$residuals, col=3, pch=20, cex=1.5)
plot(reg4$fitted,reg4$residuals, col=4, pch=20, cex=1.5)

