#################
## Wage Profile #
#################
## Code to accompany Lecture on 
## Regression
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io

rm(list=ls())
library(ISLR) # contains the data set 'Wage'
library(gam)
attach(Wage)

# Polynomial Regression
# ---------------------
fit = lm(wage ~ poly(age,4,raw=T)) # degree-4 polynomial
summary(fit)

# Piecewise Constant Regression
# -----------------------------
# cut(x,M) divides x into M pieces of equal length and generates the corresponding dummy variables
fit = lm(wage ~ 0 + cut(age,4)) # no intercept
summary(fit)

# Cubic Spline and Natural Cubic Spline
# -------------------------------------
# bs() generates B-spline basis functions with specified degrees of polynomials and knots 
fit = lm(wage ~ bs(age,knots=c(25,40,60),degree=3)) # knots at age 25,40,60
summary(fit)

# ns() fits a natural cubic spline
fit2 = lm(wage ~ ns(age,knots=c(25,40,60)))

# GAM
# ---
fit = lm(wage ~ poly(year,2) + ns(age,knots=c(25,40,60)) + education)
summary(fit)

detach(Wage)