###########
## Voting #
###########
## Code to accompany Lecture on 
## Classification
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io

library("gmodels")
library("MASS")

## reading data
rm(list = ls())
voting <- read.csv("voting.txt")
attach(voting)

## visualization
boxplot(income~vote,xlab="vote",ylab="income",cex.lab=1.5)

income_0 <- income[vote==0]
income_1 <- income[vote==1]

hist(income_0,prob=TRUE,col="cornflowerblue",
     ylim=c(0,3.5), xlim=c(-.25,1), xlab="Income of vote=0", main="") 
lines(density(income_0),col="brown",lwd=2, lty=2) 
curve(dnorm(x, mean=mean(income_0), sd=sd(income_0)), col="burlywood", lwd=2, add=TRUE)
legend("topleft", legend=c("normal fit","nonparametric fit"),
       lty=1:2,col=c("burlywood","brown"),lwd=2,bty="n") 

hist(income_1,prob=TRUE,col="cornflowerblue",
     ylim=c(0,3.5), xlim=c(0,1.25), xlab="Income of vote=1", main="") 
lines(density(income_1),col="brown",lwd=2, lty=2) 
curve(dnorm(x, mean=mean(income_1), sd=sd(income_1)), col="burlywood", lwd=2, add=TRUE)
legend("topleft", legend=c("normal fit","nonparametric fit"),
       lty=1:2,col=c("burlywood","brown"),lwd=2,bty="n") 

######################
## Linear Regression #
######################
lsfit <- lm(vote~income)
summary(lsfit)

# prediction on training data
ls.p <- lsfit$fit
lsvote <- as.numeric(ls.p > .5)
table(lsvote,vote,dnn=c("LS predicted vote","true vote"))
# for a prettier table:
CrossTable(lsvote,vote,digits=2,prop.r=FALSE,prop.t=FALSE,prop.chisq=FALSE,
           dnn=c("LS predicted vote","true vote"),format="SPSS")
plot(ls.p ~ as.factor(vote),
     xlab="Vote", ylab=c("predicted probability"), 
     col=c("cornflowerblue","brown"),main="Linear Regression")

# prediction on income = seq(0,1,.01)
lspred_prob <- predict(lsfit,data.frame(income = seq(0,1,.01)))
lspred_vote <- as.numeric(lspred_prob > .5)

# plot
xx <- seq(0,1,.01)
lsplane <- xx[min(which(lspred_prob > .5))]
plot(income,vote,ylim=c(-.5,1.5),col="cornflowerblue")
lines(xx,lspred_prob,col="brown",lwd=2)
abline(v=lsplane,lty=2,col="goldenrod")
text(lsplane+.01,-.3,paste("income=",lsplane),pos=4,col="goldenrod")
par(new=TRUE)
plot(xx,lspred_vote,col="yellow",xlab="",ylab="",ylim=c(-.5,1.5), axes=FALSE)
legend("bottomright", legend=c("data","linear prediction","linear fit"),
       lty=c(0,0,1),pch=c(1,1,NA),col=c("cornflowerblue","yellow","brown"),bty="n") 

########################
## Logistic Regression #
########################
logitfit <- glm(vote~income,family=binomial)
summary(logitfit)

# prediction on training data
logit.p <- logitfit$fit
logitvote <- as.numeric(logit.p > .5)
table(logitvote,vote,dnn=c("Logistic predicted vote","true vote"))
CrossTable(logitvote,vote,digits=2,prop.r=FALSE,prop.t=FALSE,prop.chisq=FALSE,
           dnn=c("Logistic predicted vote","true vote"),format="SPSS")
plot(logit.p ~ as.factor(vote),
     xlab="Vote", ylab=c("predicted probability"), 
     col=c("cornflowerblue","brown"),main="Logistic Regression")

# prediction on income = seq(0,1,.01)
logitpred_prob <- predict(logitfit,data.frame(income=seq(0,1,.01)),type="response")
logitpred_vote <- as.numeric(logitpred_prob > .5)

# plot
xx <- seq(0,1,.01)
logitplane <- xx[min(which(logitpred_prob > .5))]
plot(income,vote,col="cornflowerblue")
lines(xx,logitpred_prob,col="brown",lwd=2)
abline(v=logitplane,lty=2,col="goldenrod")
text(logitplane+.01,.25,paste("income=",logitplane),pos=4,col="goldenrod")
par(new=TRUE)
plot(xx,logitpred_vote,col="yellow",xlab="",ylab="", axes=FALSE)
legend("bottomright", legend=c("data","logistic prediction","logistic fit"),
       lty=c(0,0,1),pch=c(1,1,NA),col=c("cornflowerblue","yellow","brown"),bty="n") 

## Comparison
plot(income,vote,col="cornflowerblue",ylim=c(-.5,1.5))
lines(xx,lspred_prob,col="burlywood",lwd=2)
lines(xx,logitpred_prob,col="brown",lwd=2)
legend("bottomright", legend=c("linear fit","logistic fit"),
       lty=1,lwd=2,col=c("burlywood","brown"),bty="n") 

###########
## Probit #
###########
probitfit <- glm(vote~income,family = binomial(link = "probit"))
summary(probitfit)

# prediction on income = seq(0,1,.01)
probitpred_prob <- predict(probitfit,data.frame(income=seq(0,1,.01)),type="response")

# plot
xx <- seq(0,1,.01)
plot(income,vote,col="cornflowerblue",ylim=c(-.5,1.5))
lines(xx,logitpred_prob,col="brown",lwd=2)
lines(xx,probitpred_prob,col="burlywood",lwd=2)
legend("bottomright", legend=c("logistic fit","probit fit"),
       lty=1,lwd=2,col=c("brown","burlywood"),bty="n") 

detach(voting)
