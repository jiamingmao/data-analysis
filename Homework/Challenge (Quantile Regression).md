# Quantile Regression
# Homework Challenge (2 Extra Points)

## Introduction

Least Squares regression can be viewed as estimating the following model: $$E[y|x] = \beta'x$$ 
To estimate $\beta$, we solve the following L2 error minimization problem: $$\widehat{\beta}=\min\left\{\sum_{i=1}^{n}\left(y_i-\beta'x_i\right)^{2}\right\}$$

Now, suppose instead of the **conditional mean**, we are interested in estimating the **conditional median**, and our model is:  $$\text{Median}[y|x] = \beta'x$$ 
Then $\widehat{\beta}$ can be obtained by minimizing the following L1 error minimization problem: $$\widehat{\beta}=\min\left\{\sum_{i=1}^{n}\left|y_i-\beta'x_i\right|\right\}$$ This is called **least absolute deviation (LAD) regression**. 

More generally, let $Q_{\tau}(y)$ denote the $\tau-\text{th}$ quantile of $y$ (e.g., $Q_{\frac{1}{2}}(y)=\text{Median}(y)$). **Quantile regression** seeks to model the **conditional quantile** of $y$ given $x$. Suppose $$Q_{\tau}(y|x) = \beta'x$$ Then we can estimate $\beta$ by minimizing the following problem: $$\widehat{\beta}=\min\left\{ \sum_{i=1}^{n}\rho_{\tau}\left(y_{i}-\beta'x_{i}\right)\right\}$$, where the **loss function** $\rho_{\tau}(.)$ is defined as $$\rho_{\tau}\left(e\right)=e\left(\tau-\mathcal{I}\left(e<0\right)\right)$$

## Tasks
1. Write a formal introduction to quantile regression and quantile treatment effects.
2. Empirical implementation of quantile regression for estimating quantile treatment effects using real or simulated data

## Readings

### General ([link](https://github.com/jiamingmao/data-analysis/tree/master/Materials/Regression) to papers)

- Koenker, R. And K. Hallock. (2001) "Quantile Regression," *Journal of Economic Perspectives*, 15(4).
- Koenker, R. (2017) "Quantile Regression 40 Years On," *Annual Review of Economics*, 9.
- Koenker, R., V. Chernozhukov, X. He, L. Peng. (Eds.). (2018). *Handbook of Quantile Regression*. CRC Press.

### Treatment Effects under Unconfoundedness ([link](https://github.com/jiamingmao/data-analysis/tree/master/Materials/Treatment%20Effects%20under%20Unconfoundedness) to papers)

- Powell, D. (2020). "Quantile Treatment Effects in the Presence of Covariates," *The Review of Economics and Statistics*, 102(5).

### Instrumental Variables ([link](https://github.com/jiamingmao/data-analysis/tree/master/Materials/Instrumental%20Variables) to papers)

- Abadie, A., Angrist, J., and Imbens, G. (2002). "Instrumental variables estimates of the effect of subsidized training on the quantiles of trainee earnings," *Econometrica,* 70(1).
- Chernozhukov, V. and C. Hansen. (2005). "An IV Model of Quantile Treatment Effects," *Econometrica*, 73(1).
- Chernozhukov, V. and C. Hansen. (2006). "Instrumental quantile regression inference for structural and treatment effect models," *Journal of Econometrics*, 132(2).
- Chernozhukov, V. and C. Hansen. (2013). "Quantile Models with Endogeneity," *Annual Review of Economics*, 5.

### Difference-in-Differences ([link](https://github.com/jiamingmao/data-analysis/tree/master/Materials/Difference-in-differences%20and%20Synthetic%20Control) to papers)

- Callway, B. and T. Li (2019). "Quantile treatment effects in difference in differences models with panel data," *Quantitative Economics*, 10(4).

### Regression Discontinuity ([link](https://github.com/jiamingmao/data-analysis/tree/master/Materials/Regressin%20Discontinuity) to papers)

- Frandsen, B. R., Frolich, M., and Melly, B. (2012). "Quantile treatment effects in the regression discontinuity design," *Journal of Econometrics*, 168(2)

### Software ([link](https://github.com/jiamingmao/data-analysis/tree/master/Materials/Regression) to papers)

- Frolich, M. and B. Melly. (2010). "Estimation of quantile treatment effects with Stata," *The Stata Journal*, 10(3).
- Callaway, B., [Quantile Treatment Effects in R: The qte Package](https://cran.r-project.org/web/packages/qte/vignettes/R-QTEsWrapper.pdf) [[website](http://bcallaway11.github.io/qte/)]


