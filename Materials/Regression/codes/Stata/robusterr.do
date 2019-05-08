***************************
** Robust Standard Errors *
***************************
** Code to accompany Lecture on 
** Regression
** Jiaming Mao (jmao@xmu.edu.cn)
** https://jiamingmao.github.io

insheet using "robustdata.csv",clear

* simple standard errors based on homoskedasticity assumption
regress y x

* Breusch-Pagan test for heteroskedasticity
estat hettest

* heteroskedasticity-consistent (HC) standard errors 
regress y x, vce(robust)
