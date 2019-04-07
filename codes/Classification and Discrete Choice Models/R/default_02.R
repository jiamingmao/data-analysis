########################
## Credit Card Default #
########################
## Code to accompany Lecture on 
## Classification
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io

library(ISLR)
library(AER)
library(class)
library(lattice)
library(MASS)

## reading data
rm(list = ls())
attach(Default)
dim(Default)
head(Default)
Default <- Default[,-2] 
set.seed(123) 
cutoff <- .5
test <- sample(1:nrow(Default),2000) ## sample 2000 random indices
TR.X <- Default[-test,-1]
TE.X <- Default[test,-1]
TR.y <- default[-test]
TE.y <- default[test]
#source("roc.R")

## Visualize
xyplot(income ~ balance,groups=default)

## Linear Regression
y <- as.numeric(TR.y) - 1 # y in {0,1}
lsfit <- lm(y ~ ., data=TR.X)
summary(lsfit)
ls.p <- predict(lsfit,TE.X)
ls.pred <- as.factor(ls.p > cutoff)
levels(ls.pred) <- c("No","Yes")
table(ls.pred,TE.y)
plot(TE.y,ls.pred,col=c("slategrey","orange"),
     ylab="predicted",xlab="",main="Linear Regression")
plot(ls.p~TE.y, 
     xlab="", ylab=c("predicted probability"), 
     col=c("cornflowerblue","brown"),main="Linear Regression")

########
## LDA #
########
ldafit <- lda(TR.y ~., data=TR.X)
ldafit
#ldapred <- predict(ldafit,TE.X)
#lda.pred <- ldapred$class
lda.p <- predict(ldafit,TE.X)$posterior[,2]
lda.pred <- as.factor(lda.p > cutoff)
levels(lda.pred) <- c("No","Yes")
table(lda.pred,TE.y)
plot(TE.y,lda.pred,col=c("slategrey","orange"),
     ylab="predicted",xlab="",main="LDA")
plot(lda.p~TE.y, 
     xlab="", ylab=c("predicted probability"), 
     col=c("cornflowerblue","brown"),main="LDA")

#############
## Logistic #
#############
logitfit <- glm(TR.y ~., data=TR.X, family=binomial)
summary(logitfit)
logit.p <- predict(logitfit,TE.X,type="response")
logit.pred <- as.factor(logit.p > cutoff)
levels(logit.pred) <- c("No","Yes")
table(logit.pred,TE.y)
plot(TE.y,logit.pred,col=c("slategrey","orange"),
     ylab="predicted",xlab="",main="Logistic Regression")
plot(logit.p~TE.y, 
     xlab="", ylab=c("predicted probability"), 
     col=c("cornflowerblue","brown"),main="Logistic Regression")

########
## KNN #
########
s.balance <- scale(balance)
s.income <- scale(income)
SX <- data.frame(s.balance,s.income)
TR.SX <- SX[-test,]
TE.SX <- SX[test,]

knn.pred <- knn(TR.SX,TE.SX,TR.y,k=5,prob=TRUE)
knn.wp <- attributes(knn.pred)$prob #this is the proportion of votes for the winning class
#let knn.p be the proportion of votes for y=1, i.e. knn.p = Pr(y=1|x)
knn.p <- numeric(length(knn.pred)) 
knn.p[knn.pred=="No"] <- 1 - knn.wp[knn.pred=="No"]
knn.p[knn.pred=="Yes"] <- knn.wp[knn.pred=="Yes"]
table(knn.pred,TE.y)
plot(TE.y,knn.pred,col=c("slategrey","orange"),
     ylab="predicted",xlab="",main="KNN=5")
plot(knn.p~TE.y, 
     xlab="", ylab=c("predicted probability"), 
     col=c("cornflowerblue","brown"),main="KNN=5")

########
## ROC #
########
n <- length(test)
y <- TE.y
p.ls <- as.vector(ls.p)
# let m = matrix(rep(seq(0,1,length=100),n),ncol=100,byrow=TRUE) 
# m is amatrix where each row contains threshold values that go from 0 to 1 
# (increment approx. 0.1, total 100 columns) and the number of rows = number of observations 
# let p be the predicted Pr(y=1|x). Let Q = p > m. Then Q is a matrix
# where each cell is TRUE/FALSE depending on whether p > the threshold value (column) 
# for that observation (row).
# For observations with y=0, the mean value of a column of Q gives the prob that we incorrectly 
# classify y for that threshold value (column). This is 1-specificity
# For observations with y=1, the mean value of a column of Q gives the prob that we correctly 
# classify y for that threshold value (column). This is sensitivity.
Q.ls <- p.ls > matrix(rep(seq(0,1,length=100),n),ncol=100,byrow=TRUE)
specificity.ls <- colMeans(!Q.ls[y==levels(y)[1],])
sensitivity.ls <- colMeans(Q.ls[y==levels(y)[2],])
plot(1-specificity.ls, sensitivity.ls,type="o",bty="n",
     col="blue",lwd=2,pch=0,
     xlab="1 - Specificity",ylab="Sensitivity",
     xlim=c(0,1),ylim=c(0,1))

p.logit <- as.vector(logit.p)
Q.logit <- p.logit > matrix(rep(seq(0,1,length=100),n),ncol=100,byrow=TRUE)
specificity.logit <- colMeans(!Q.logit[y==levels(y)[1],])
sensitivity.logit <- colMeans(Q.logit[y==levels(y)[2],])
lines(1-specificity.logit, sensitivity.logit,
      col="red",pch=2,lwd=2,type="o")

p.knn <- as.vector(knn.p)
Q.knn <- p.knn > matrix(rep(seq(0,1,length=100),n),ncol=100,byrow=TRUE)
specificity.knn <- colMeans(!Q.knn[y==levels(y)[1],])
sensitivity.knn <- colMeans(Q.knn[y==levels(y)[2],])
lines(1-specificity.knn, sensitivity.knn,col="green",lwd=2,
      pch=1,type="o")

abline(a=0,b=1,lty=2,col=8)
legend("bottomright",
       legend=c("linear regression","logistic regression","KNN=5"),
       lwd=c(2,2,2),pch=c(0,2,1),
       col=c("blue","red","green"))
    
##
detach(Default)

