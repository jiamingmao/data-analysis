***OLS***
** Author: Yuzhou Yang (https://github.com/yangyuzhou001)
** The origin R code is from https://github.com/jiamingmao/data-analysis/tree/master/codes/Regression/Stata

clear 
browse
set more off
set matsize 500
cap log close
log using ols.txt, text replace

***generate some data***

import delim using outputOls.csv, delim(" ") clear
rename v* (id e y x1 x2)

**regression**

reg y x1 x2

** manual solution: method 1

gen ones = 1
mkmat ones x1 x2, matrix(X)
mkmat y, matrix(Y)
matrix b = invsym(X'*X) * X' * Y
mat list b

** manual solution: method 2
reg x1 x2
predict u1, residuals
corr u1 y, cov
scalar b1 = r(cov_12)/r(Var_1)
display b1

reg x2 x1

predict u2, residuals
scalar b2 = r(cov_12)/r(Var_1)
display b2

scalar b0 = mean(y) - b1*mean(x1) - b2*mean(x2)
display b0 b1 b2

*scatter plot of y vs u1 and u2

twoway scatter y u1, m(Oh) || lfit y u1 ||, legend(off) scheme(s1color)
twoway scatter y u2, m(Oh) || lfit y u2 ||, legend(off) scheme(s1color)

log close
