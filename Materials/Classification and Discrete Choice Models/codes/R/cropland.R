#############
## Cropland #
#############
## Code to accompany Lecture on 
## Classification
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io

## reading data
rm(list = ls())
attach(read.csv("cropland.txt"))
     
## Linear Regression 
lsfit <- lm(percentCultivated ~ temperature)
summary(lsfit)

## Linear Regression with target transform
p <- percentCultivated
eps <- 1e-4
p[p==1] = p[p==1] - eps
z <- log(p/(1-p))
lsfit2 <- lm(z ~ temperature)
summary(lsfit2)

## Logistic
logitfit <- glm(cbind(cultivated,fields-cultivated) ~ temperature,family=binomial)
summary(logitfit)

## Prediction
mintemp <- -5
maxtemp <- 40
newdata <- data.frame(temperature=seq(mintemp,maxtemp,.1)) #predict p from mintemp to maxtemp
#prediction of logistic regression
logitpred <- predict(logitfit,newdata,type="response")
#prediction of linear regression 1
lspred <- predict(lsfit,newdata,type="response") 
#prediction of linear regression 2
zpred <- predict(lsfit2,newdata,type="response")
lspred2 <- exp(zpred)/(1+exp(zpred))

## Plot
xx <- seq(mintemp,maxtemp,.1)
plot(temperature,percentCultivated,pch='.',col="cornflowerblue",
     xlim=c(mintemp,maxtemp), ylim=c(-.2,1.5))
lines(xx,logitpred,col="brown",lwd=2)
lines(xx,lspred,col="forestgreen",lwd=2)
lines(xx,lspred2,col="burlywood",lwd=2)
abline(a=1,b=0,lty=3)
abline(a=0,b=0,lty=3)
legend("topright", legend=c("logistic fit","linear fit","linear fit with target transform"),
       lty=1,lwd=2,col=c("brown","forestgreen","burlywood"),bty="n") 

