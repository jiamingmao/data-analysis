########
## MLE #
########
## Code to accompany Lecture on 
## Regression
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io/data-analysis/

library(bbmle)
rm(list=ls())
set.seed(5)

## generate data
n <- 500
e <- rnorm(n)
x1 <- runif(n)
x2 <- 0.5*x1 + 0.5*runif(n)
y <- 1 - 2.5*x1 + 5*x2 + e

# define the negative log likelihood function
nll <-function(theta){
  beta0 <- theta[1]
  beta1 <- theta[2]
  beta2 <- theta[3]
  sigma <- theta[4]
  N <- length(y)
  z <- (y - beta0 - beta1*x1 - beta2*x2)/sigma
  logL <- -1*N*log(sigma) - 0.5*sum(z^2)
  return(-logL)}

# perform optimization
mlefit <- optim(c(0,0,0,1),nll)
mlefit$par

# alternatively, use the mle2 function from the bbmle package
parnames(nll) <- c("beta0","beta1","beta2","sigma")
result <- mle2(nll,start=c(beta0=0,beta1=0,beta2=0,sigma=1))
summary(result)
