####################################
## Statistical Significance Filter #
####################################
## Code to accompany Lecture on 
## The Truth About P-Values
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io
## credit: Kenkel, B. (http://bkenkel.com/psci8357/notes/03-crisis.html)

library("dplyr") 
library("foreach") 
library("ggplot2") 
library("broom")
rm(list=ls())
set.seed(5) 

M <- 100 # number of random samples
N <- 200 # number of data points per sample
beta_hat_dist <- replicate(100, { 
  x <- rbinom(N,1,0.5)
  y <- 1 + 0.1*x + rnorm(N)
  fit <- lm(y ~ x)
  coef <- tidy(fit) %>% filter(term == "x")
  c(beta_hat = coef$estimate, p_value = coef$p.value) # coefficient and p-value on x
})

## E(beta_hat)
beta_hat_dist <- as.data.frame(t(beta_hat_dist))
beta_hat_dist %>% summarise (e_beta_hat = mean(beta_hat))

## visualize
# plot 1
significant = (beta_hat_dist$p_value <= .05)
ggplot(beta_hat_dist, aes(x=1:100, y=beta_hat, color=significant)) + 
  geom_point(size=2) + xlab('replication')

# plot 2
plot(beta_hat_dist,pch=19,col="cornflowerblue")
abline(a=.05,b=0,col="red",lwd=2,lty=2)

## beta_hat by significance
beta_hat_dist <- mutate(beta_hat_dist, significant = p_value <= .05) 
beta_hat_dist %>% group_by(significant) %>% 
  summarise(count = n(), e_beta_hat = mean(beta_hat))

## run the same simulation for beta = .2, .3, .4. .5
beta_seq <- seq(0.2, 0.5, by=0.1)  
foreach (beta = beta_seq) %do% { 
  beta_hat_dist <- replicate(100, {       
    x <- rbinom(N,1,0.5)   
    y <- 1 + beta * x + rnorm(N)     
    fit <- lm(y ~ x)   
    coef <- tidy(fit) %>% filter(term == "x") 
    c(beta_hat = coef$estimate, p_value = coef$p.value)
  })
  beta_hat_dist <- as.data.frame(t(beta_hat_dist))      
  beta_hat_dist <- mutate(beta_hat_dist, significant = p_value <= 0.05)   
  beta_hat_dist %>% group_by(significant) %>% 
    summarise(count = n(), e_beta_hat = mean(beta_hat)) 
}  
