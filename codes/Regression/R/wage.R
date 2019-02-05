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

## plotting
agelims = range(age) 
age.grid = seq(from=agelims[1], to=agelims[2]) 
preds = predict(fit, newdata=list(age=age.grid), se=TRUE) 
se.bands = cbind(preds$fit + 2*preds$se.fit, preds$fit - 2*preds$se.fit)
plot(age, wage, xlim=agelims, cex=.5, col="darkgrey") 
lines(age.grid, preds$fit, lwd=2, col="darkblue") 
matlines(age.grid, se.bands, lwd=1, col="darkblue", lty=3)
title("Degree-4 Polynomial")

# Piecewise Constant Regression
# -----------------------------
# cut(x,M) divides x into M pieces of equal length and generates the corresponding dummy variables
fit = lm(wage ~ 0 + cut(age,4)) # no intercept
summary(fit)

## plotting
preds = predict(fit, newdata=list(age=age.grid), se=TRUE) 
se.bands = cbind(preds$fit + 2*preds$se.fit, preds$fit - 2*preds$se.fit)
plot(age, wage, xlim=agelims, cex=.5, col="darkgrey") 
lines(age.grid, preds$fit, lwd=2, col="darkgreen") 
matlines(age.grid, se.bands, lwd=1, col="darkgreen", lty=3)
title("Piecewise Constant")

# Cubic Spline and Natural Cubic Spline
# -------------------------------------
# bs() generates B-spline basis functions with specified degrees of polynomials and knots 
fit = lm(wage ~ bs(age,knots=c(25,40,60),degree=3)) # knots at age 25,40,60
summary(fit)

# ns() fits a natural cubic spline
fit2 = lm(wage ~ ns(age,knots=c(25,40,60)))

## plotting
preds = predict(fit, newdata=list(age=age.grid), se=TRUE) 
se.bands = cbind(preds$fit + 2*preds$se.fit, preds$fit - 2*preds$se.fit)
preds2 = predict(fit2, newdata=list(age=age.grid), se=TRUE) 
se2.bands = cbind(preds2$fit + 2*preds2$se.fit, preds2$fit - 2*preds2$se.fit)
plot(age, wage, xlim=agelims, cex=.5, col="darkgrey") 
lines(age.grid, preds$fit, lwd=2, col="darkblue") 
matlines(age.grid, se.bands, lwd=1, col="darkblue", lty=3)
lines(age.grid, preds2$fit, lwd=2, col="darkorange") 
matlines(age.grid, se2.bands, lwd=1, col="darkorange", lty=3)
abline(v=c(25,40,60),lty=3) 
legend("topright", col=c("darkblue","darkorange"), lwd=2, legend=c("Cubic Spline","Natural Cubic Spline"), bty="n")
title("Cubic and Natural Cubic Spline")

# GAM
# ---
fit = lm(wage ~ poly(year,2) + ns(age,knots=c(25,40,60)) + education)
summary(fit)
par(mfrow =c(1,3))
plot.gam(fit, se=TRUE, col="brown")

detach(Wage)