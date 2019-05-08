###########
## Probit #
###########
## Code to accompany Lecture on 
## Classification
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io

library(MASS)
library(ramify)

################
# Experiment 1 #
################

## generate data
rm(list = ls())
set.seed(3)
n = 1e3
s = runif(n) 
e1 <- rnorm(n,mean=1,sd=1)
e2 <- rnorm(n,mean=-1,sd=2)
u1 <- 5 - 10*s + e1
u2 <- -5 + 10*s + e2
U <- cbind(u1,u2)
y <- argmax(U) #require("ramify")
y <- factor(y)
prop.table(table(y))
mydata <- data.frame(s,y)
head(mydata)

## visualize data
boxplot(s~y,xlab="y",ylab="s", col=c("cornflowerblue","brown"))

## Probit regression
probitfit <- glm(y ~ s,family = binomial(link = "probit"))
summary(probitfit)

## true beta
beta_true <- c(-12,20)/sqrt(5)
beta_true

################
# Experiment 2 #
################
mu <- c(1,-1)
sig <- c(1,2)
rho <- .5
Sigma <- matrix(c(sig[1]^2,rho*sig[1]*sig[2],
                  rho*sig[1]*sig[2],sig[2]^2),2,2)
e <- mvrnorm(n,mu,Sigma) # require("MASS")
colMeans(e)
var(e)
e1 <- e[,1]
e2 <- e[,2]
u1 <- 5 - 10*s + e1
u2 <- -5 + 10*s + e2
U <- cbind(u1,u2)
y <- argmax(U) 
y <- factor(y)
prop.table(table(y))

## Probit regression
probitfit <- glm(y ~ s,family = binomial(link = "probit"))
summary(probitfit)

## true beta
beta_true <- c(-12,20)/sqrt(sig[1]^2+sig[2]^2-2*rho*sig[1]*sig[2])
beta_true


################
# Experiment 3 #
################
z1 <- 100*runif(n)
z2 <- 50*runif(n)
e1 <- rnorm(n,mean=1,sd=1)
e2 <- rnorm(n,mean=-1,sd=2)
u1 <- 5 - 10*s -.1*z1 + e1
u2 <- -5 + 10*s -.1*z2 + e2
U <- cbind(u1,u2)
y <- argmax(U) 
y <- factor(y)
prop.table(table(y))
mydata <- data.frame(s,z1,z2,y)
head(mydata)

## Probit regression 1
probitfit <- glm(y ~ s + z1 + z2,family = binomial(link = "probit"))
summary(probitfit)

## Probit regression 2
dz = z2 - z1
probitfit <- glm(y ~ s + dz,family = binomial(link = "probit"))
summary(probitfit)