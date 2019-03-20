##################
## Dose Response #
##################
## Code to accompany Lecture on 
## Classification
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io

## generate data
rm(list = ls())
y <- c(0,1,4,6,6)
n <- c(6,6,6,6,6)
logconc <- c(-5,-4,-3,-2,-1)
p <- y/n

## logistic regression
logitfit <- glm(cbind(y,n-y) ~ logconc,family=binomial)
summary(logitfit)

## linear regression 
lsfit1 <- lm(p ~ logconc)
summary(lsfit1)

## linear regression with target transform
eps <- 1e-4
p[p==0] = p[p==0] + eps
p[p==1] = p[p==1] - eps
z = log(p/(1-p))
lsfit2 <- lm(z ~ logconc)
summary(lsfit2)

## prediction
minx <- -6
maxx <- 0
newdata <- data.frame(logconc=seq(maxx,minx,-.1)) #predict p from minx to maxx
#prediction of logistic regression
logitpred <- predict(logitfit,newdata,type="response")
#prediction of linear regression 1
lspred1 <- predict(lsfit1,newdata,type="response")
#prediction of linear regression 2
zpred <- predict(lsfit2,newdata,type="response")
lspred2 <- exp(zpred)/(1+exp(zpred))

## Plot
xx <- seq(maxx,minx,-.1)
plot(logconc,p,col="cornflowerblue",xlim=c(minx,maxx),ylim=c(-.5,1.5))
lines(xx,logitpred,col="brown",lwd=2)
lines(xx,lspred1,col="forestgreen",lwd=2)
lines(xx,lspred2,col="burlywood",lwd=2)
abline(a=1,b=0,lty=3)
abline(a=0,b=0,lty=3)
legend("bottomright", legend=c("logistic fit","linear fit","linear fit with target transform"),
       lty=1,lwd=2,col=c("brown","forestgreen","burlywood"),bty="n") 
