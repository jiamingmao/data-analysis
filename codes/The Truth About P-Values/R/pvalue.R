#########################
## Posterior Prob of H0 #
#########################
## Code to accompany Lecture on 
## The Truth About P-Values
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io

rm(list=ls())

## Numerical Example
p_H0 <- .9 #Pr(H0)
p_H1 <- 1 - p_H0 #Pr(H1)
p_D_H0 <- seq(.01, .05, by = .01) #Pr(D|H0), i.e. p-value
p_D_H1 <- .8 #Pr(D|H1)
p_H0_D <- (p_D_H0*p_H0)/(p_D_H0*p_H0 + p_D_H1*p_H1) #Pr(H0|D)

## Plot 
p_D_H0 <- seq(0, 0.05, by = 0.001)
p_H0_D <- (p_D_H0*p_H0)/(p_D_H0*p_H0 + p_D_H1*p_H1)
plot(p_D_H0,p_H0_D,col=0,xlab="p-value",ylab="Posterior Prob of H0",cex.lab=1.25) 
lines(p_D_H0,p_H0_D,lwd=2,col="cornflowerblue") 
abline(a=.05,b=0,col="brown")
abline(v=.0045,col="brown") 
text(.01,.3,"p-value=.004",col="brown") 
text(.04,.08,"Pr(H0|D)=.05",col="brown")
