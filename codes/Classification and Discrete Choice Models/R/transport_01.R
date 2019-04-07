###################
## Transportation #
###################
## Code to accompany Lecture on 
## Classification
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io

library(nnet)
library(lattice)
library(latticeExtra)
library(ggplot2)
library(AER)
library(ramify)

## reading data
rm(list = ls())
transport <- read.csv("Transport.txt")
loginc <- transport$LogIncome
distance <- transport$DistanceToWork
y <- transport$ModeOfTransportation
N <- nrow(transport)

## summarize and visualize data
income <- exp(loginc)
cbind(mean(income[y=="bus"]),mean(income[y=="car"]),mean(income[y=="subway"]))
cbind(mean(distance[y=="bus"]),mean(distance[y=="car"]),mean(distance[y=="subway"]))
ggplot(transport,aes(x=loginc,y=distance,color=y)) + geom_point(size=1.5) 
xyplot(distance ~ loginc | y, groups=y, par.settings = simpleTheme(pch=20))

## logistic regression
logitfit <- multinom(y ~ loginc + distance) 
summary(logitfit)

## visualize decision boundaries
# plot 1
XX <- expand.grid(loginc=pretty(loginc, 20),distance=pretty(distance, 20))
logit.pr <- predict(logitfit,XX,type="probs")
bd12 <- apply(logit.pr, 1, function(x) x[1]-x[2])
bd23 <- apply(logit.pr, 1, function(x) x[2]-x[3])
bd13 <- apply(logit.pr, 1, function(x) x[1]-x[3])
fig1.main <- contourplot(bd12 ~ loginc*distance,data=XX,at=0,labels=list(labels="bus vs. car",col="maroon"),
                         col="maroon",label.style="flat")
fig1.addlayer1 <- latticeExtra::as.layer(
  contourplot(bd23 ~ loginc*distance,data=XX,at=0,labels=list(labels="subway vs. car",col="cornflowerblue"),
              col="cornflowerblue",label.style="flat"), axes=FALSE)
fig1.addlayer2 <- latticeExtra::as.layer(
  contourplot(bd13 ~ loginc*distance,data=XX,at=0,labels=list(labels="bus vs. subway",col="burlywood"),
              col="burlywood",label.style="flat"), axes=FALSE)
fig1.main + fig1.addlayer1 + fig1.addlayer2

# plot 2
diff1 <- apply(logit.pr, 1, function(x)x[1]-max(x[-1]))
diff2 <- apply(logit.pr, 1, function(x)x[2]-max(x[-2]))
diff3 <- apply(logit.pr, 1, function(x)x[3]-max(x[-3]))
contourplot(diff1 ~ loginc*distance,data=XX)
contourplot(diff2 ~ loginc*distance,data=XX)
contourplot(diff3 ~ loginc*distance,data=XX)

## prediction
logit.yhat <- predict(logitfit)
table(logit.yhat,y)
sum(diag(table(logit.yhat,y)))/N

## visualize prediction
# plot 1
true.predicted <- interaction(y,logit.yhat)
ggplot(transport,aes(x=loginc,y=distance,color=true.predicted)) + geom_point(size=1.5) 

# plot 2
fig2.main <- xyplot(distance ~ loginc, groups=y, auto.key=list(space="right"), aspect=1,
                    par.settings = simpleTheme(pch=20),
                    grid=TRUE,
                    alpha=.5)
diff1 <- apply(logit.pr, 1, function(x)x[1]-max(x[-1]))
diff2 <- apply(logit.pr, 1, function(x)x[2]-max(x[-2]))
diff3 <- apply(logit.pr, 1, function(x)x[3]-max(x[-3]))
fig2.addlayer1 <- latticeExtra::as.layer(
  contourplot(diff1 ~ loginc*distance,data=XX,at=0,labels="",lty=3,lwd=1.5), axes=FALSE)
fig2.addlayer2 <- latticeExtra::as.layer(
  contourplot(diff2 ~ loginc*distance,data=XX,at=0,labels="",lty=2,lwd=1.5), axes=FALSE)
fig2.addlayer3 <- latticeExtra::as.layer(
  contourplot(diff3 ~ loginc*distance,data=XX,at=0,labels="",lty=2,lwd=1.5), axes=FALSE)
fig2.main + fig2.addlayer1 + fig2.addlayer2 + fig2.addlayer3
trellis.focus("toplevel") ## has coordinate system [0,1] x [0,1]
panel.text(0.325, 0.45,"bus",font=2)
panel.text(0.425, 0.75,"subway",font=2)
panel.text(0.7, 0.45,"car",font=2)
trellis.unfocus()

## counterfactual prediction: without subway
logit.pr <- predict(logitfit,type="probs")
logit.pc <- logit.pr[,c(1,2)] # without subway
logit.yc <- as.factor(argmax(logit.pc))
levels(logit.yc) <- c("bus","car")
table(logit.yc,logit.yhat)

## visualize counterfactual
original.counterfactual <- interaction(logit.yhat,logit.yc)
ggplot(transport,aes(x=loginc,y=distance,color=original.counterfactual,main="haha")) + geom_point(size=1.5) +
  ggtitle("Original Prediction vs. Counterfactual Prediction")
fig3.main <- xyplot(distance ~ loginc, groups=logit.yc, auto.key=list(space="right"), aspect=1,
                    par.settings = simpleTheme(pch=20),
                    grid=TRUE,
                    alpha=.5,main="Counterfactual Prediction")
fig3.main + fig2.addlayer1 + fig2.addlayer2 + fig2.addlayer3

## market share comparison
marketshare.y = colMeans(logit.pr)
marketshare.y
marketshare.c = colMeans(logit.pc)
marketshare.c
