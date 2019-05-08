#####################
## Ridge Regression #
#####################
## Code to accompany Lecture on 
## Model Selection and Regularization
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io
## Credit: R. Tibshirani (http://www.stat.cmu.edu/~ryantibs/datamining)

# Small Coefficients ------------------------------------------------------
library(MASS)
rm(list = ls())

# Simulating data set
set.seed(123)
n = 50 #number of data points
p = 30 #number of coefficients
x = matrix(rnorm(n*p),nrow=n) #n-by-p
bstar = c(runif(10,0.5,1),runif(20,0,0.3))
mu = as.numeric(x%*%bstar) #n-by-1

# Histogram of true coefficents
hist(bstar,breaks=30,col="gray",main="",xlab="True coefficients")

R = 100 #number of simulations
nlam = 60 #number of lambda's
lam = seq(0,25,length=nlam)

fit.ls = matrix(0,R,n) #R-by-n
fit.rid  = array(0,dim=c(R,nlam,n)) #R-by-nlam-by-n
err.ls = numeric(R) #R-by-1
err.rid = matrix(0,R,nlam) #R-by-nlam

for (i in 1:R) {
  y = mu + rnorm(n) #generate training data
  ynew = mu + rnorm(n) #generate test data (new y conditional on x)
  
  a = lm(y~x+0) #LS regression (without intercept)
  bls = coef(a) #LS regression coefficients
  fit.ls[i,] = x%*%bls #LS fit; n-by-1
  err.ls[i] = mean((ynew-fit.ls[i,])^2) #LS prediction MSE
  
  aa = lm.ridge(y~x+0,lambda=lam) #Ridge regression
  brid = coef(aa) #Ridge regression coefficients
  fit.rid[i,,] = brid%*%t(x) #Ridge fit; n-by-1
  err.rid[i,] = rowMeans(scale(fit.rid[i,,],center=ynew,scale=F)^2) #Ridge prediction MSE
  #scale(fit.rid[i,,],center=ynew,scale=F) is nlam-by-n
}

bias.ls = sum((colMeans(fit.ls)-mu)^2)/n #scalar
var.ls = sum(apply(fit.ls,2,var))/n #scalar

bias.rid = rowSums(scale(apply(fit.rid,2:3,mean),center=mu,scale=F)^2)/n #nlam-by-1
var.rid = rowSums(apply(fit.rid,2:3,var))/n #nlam-by-1

prederr.ls = bias.ls + var.ls + 1 
prederr.rid = bias.rid + var.rid + 1 

aveerr.ls = mean(err.ls)
aveerr.rid = colMeans(err.rid)

# In theory, prederr = aveerr
cbind(prederr.ls, aveerr.ls)
cbind(prederr.rid,aveerr.rid)

# Visualization
plot(lam,prederr.rid,type="l",
     xlab="Amount of shrinkage",ylab="Prediction error")
abline(h=prederr.ls,lty=2)
text(c(1,24),c(1.48,1.48),c("Low","High"))
legend("topleft",lty=c(2,1),legend=c("Linear regression","Ridge regression"))

plot(lam,prederr.rid,type="l",ylim=c(0,max(prederr.rid)),
     xlab=expression(paste(lambda)),ylab="")
lines(lam,bias.rid,col="red")
lines(lam,var.rid,col="blue")
abline(h=prederr.ls,lty=2)
legend("right",lty=c(2,1,1,1),
       legend=c("Linear Pred Err","Ridge Pred Err","Ridge Bias^2","Ridge Var"),
       col=c("black","black","red","blue"),bty="n")


# Large Coefficients  ------------------------------------------------------
rm(list = ls())

# Simulating data set
n = 50
p = 30
x = matrix(rnorm(n*p),nrow=n)
bstar = runif(p,0.5,1)
mu = as.numeric(x%*%bstar)

# Histogram of true coefficents
hist(bstar,breaks=30,col="gray",main="",xlab="True coefficients",xlim=c(0,1))

R = 100
nlam = 60
lam = seq(0,25,length=nlam)

fit.ls = matrix(0,R,n)
fit.rid  = array(0,dim=c(R,nlam,n))
err.ls = numeric(R)
err.rid = matrix(0,R,nlam)

for (i in 1:R) {
  y = mu + rnorm(n)
  ynew = mu + rnorm(n)
  
  a = lm(y~x+0)
  bls = coef(a)
  fit.ls[i,] = x%*%bls
  err.ls[i] = mean((ynew-fit.ls[i,])^2)
  
  aa = lm.ridge(y~x+0,lambda=lam)
  brid = coef(aa)
  fit.rid[i,,] = brid%*%t(x)
  err.rid[i,] = rowMeans(scale(fit.rid[i,,],center=ynew,scale=F)^2)
}

bias.ls = sum((colMeans(fit.ls)-mu)^2)/n
var.ls = sum(apply(fit.ls,2,var))/n

bias.rid = rowSums(scale(apply(fit.rid,2:3,mean),center=mu,scale=F)^2)/n
var.rid = rowSums(apply(fit.rid,2:3,var))/n

prederr.ls = bias.ls + var.ls + 1 
prederr.rid = bias.rid + var.rid + 1

aveerr.ls = mean(err.ls)
aveerr.rid = colMeans(err.rid)

cbind(prederr.ls, aveerr.ls)
cbind(prederr.rid,aveerr.rid)

# Visualization
plot(lam,prederr.rid,type="l",
     xlab="Amount of shrinkage",ylab="Prediction error")
abline(h=prederr.ls,lty=2)
text(c(1,24),c(1.48,1.48),c("Low","High"))
legend("topleft",lty=c(2,1),legend=c("Linear regression","Ridge regression"))

plot(lam,prederr.rid,type="l",ylim=c(0,max(prederr.rid)),
     xlab=expression(paste(lambda)),ylab="")
lines(lam,bias.rid,col="red")
lines(lam,var.rid,col="blue")
abline(h=prederr.ls,lty=2)
legend("topleft",lty=c(2,1,1,1),
       legend=c("Linear pred err","Ridge pred err","Ridge bias^2","Ridge var"),
       col=c("black","black","red","blue"),bty="n")
