############################################
## Discrete Choice Model with Gumbel error #
############################################
## Code to accompany Lecture on 
## Classification and Discrete Choice Models
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io/data-analysis/

rm(list=ls())
library(VGAM) # Gumbel random number generating function

# simulate data
n = 10000
e = matrix(rgumbel(n*2),n,2) 
x = runif(n)
beta = 2
u0 = e[,1]
u1 = x*beta + e[,2] 
y = (u1 > u0)

# estimation
fit = glm(y ~ x,family="binomial")
summary(fit)




