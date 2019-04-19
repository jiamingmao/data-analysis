*************
** Anscombe *
*************
** Author: Yuzhou Yang (https://github.com/yangyuzhou001)
** The original R code is from: https://github.com/jiamingmao/data-analysis/blob/master/codes/Regression/R/auto.R
** anscombe.csv is from foreign package

clear 
browse
set more off
cap log close
log using anscombe.txt, text replace


import delim using anscombe.csv, delim(" ") clear

gen id = _n
reshape long y x, i(id) j(varname)

** visualize
twoway scatter y x, by(varname) scheme(s1mono)

** regression
forvalues i = 1/4{
	qui reg y x if varname == `i'
	display e(r2)
	predict fitted`i' if varname == `i', xb
	replace fitted`i' = 0 if fitted`i' == .
	predict res`i' if varname == `i', residuals
	replace res`i' = 0 if res`i' == .
}
order fitted* res*
egen fitted = rsum(fitted1-fitted4)
egen res = rsum(res1-res4)

** plot with the regression lines

twoway scatter y x || lfit y x ||, by(varname) scheme(s1mono)

* plot fitted values against residuals

twoway scatter res fitted, by(varname) scheme(s1mono)
