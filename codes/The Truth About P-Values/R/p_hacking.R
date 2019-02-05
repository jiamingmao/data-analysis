##############
## P Hacking #
##############
## Code to accompany Lecture on 
## The Truth About P-Values
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io
## credit: Kenkel, B. (http://bkenkel.com/psci8357/notes/03-crisis.html)

library(AER)
library(dplyr) 
library(broom)
set.seed(19)  
rm(list=ls())

#################
## Simulation 1 #
#################
N <- 100 
treatment <- rbinom(N,1,.5) 
male <- rbinom(N,1,.5)  
y <- runif(N) 

# Regression on the entire sample
fit_all <- lm(y ~ treatment) 
coeftest(fit_all)

# Regression on the male subsample
fit_male <- update(fit_all, subset = male == 1)  
coeftest(fit_male)

# Regression on the female subsample
fit_female <- update(fit_all, subset = male == 0)
coeftest(fit_female)

#################
## Simulation 2 #
#################
# function to extract P-value
extract_p <- function(fitted_model) { 
  tidy(fitted_model) %>% filter(term == "treatment") %>% 
    select(p.value) %>% as.numeric()}

# simulation
M <- 1000
sim_p_hack <- replicate(M, { 
  treatment <- rbinom(N,1,.5) 
  male <- rbinom(N,1,.5) 
  y <- runif(N) 
  fit_all <- lm(y ~ treatment) 
  fit_male <- update(fit_all, subset = male == 1) 
  fit_female <- update(fit_all, subset = male == 0)
  p_all <- extract_p(fit_all) 
  p_male <- extract_p(fit_male) 
  p_female <- extract_p(fit_female)     
  min(p_all, p_male, p_female)
})

# result
mean(sim_p_hack <= .05)

# visualize
plot(ecdf(sim_p_hack), xlab="p-value", ylab="Cumulative probability", 
     col="cornflowerblue", xlim=c(0,1), lwd=3) 
abline(a=0, b=1, lty=3, col="red", lwd=3) 
legend("topleft", c("observed", "theoretical"), lty=c(1,3),
       col=c("cornflowerblue","red"))
