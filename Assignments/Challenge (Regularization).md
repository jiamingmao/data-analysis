# Homework Challenge (4 Extra Points)

[1] Look for data from one of the following sources:

- [IPUMS](https://www.ipums.org/): including the U.S. Census, American Community Survey, CPS, and other U.S. and international survey data
- [U.S. General Social Survey (GSS)](http://gss.norc.org/)
- [China General Soical Survey (CGSS)](http://cnsda.ruc.edu.cn/)
- [European Social Survey (ESS)](https://www.europeansocialsurvey.org/)

[2] Select an interesting target variable and *at least* 50 feature variables.

Example: from the GSS, we can try to predict a person's political leaning (liberal, conservative) based on many variables such as age, place of birth, income, education, sexual orientation, ... -- choose at least 50 of them.

*Note:* the choice of x variables must be *justifiable*, i.e. you cannot simply throw all variables in. What is a justifiable feature? Using the example above, a justifiable feature is a feature that there is reason to believe may help predict a person's political leaning. In fact, probably more variables than you imagine are justifiable in this case, for example: how many times a person goes to church, whether this person believes in global warming, what type of music this person likes, how many partners he/she has had, etc. -- all available in GSS.

[3] Perform **regularized** linear or (multinomial) logistic regression (depends on whether your target variable is continuous or discrete/categorical) with either L1 regularizer (**Lasso**) or a regularizer that combines L1 and L2 (**Elastic Net**).
