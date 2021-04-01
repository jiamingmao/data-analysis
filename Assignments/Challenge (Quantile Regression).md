# Regression
# Homework Challenge (2 Extra Points)

## Introduction

Least Squares regression can be viewed as estimating the following model: $$E[y|x] = \beta'x$$ 
To estimate $\beta$, we solve the following L2 error minimization problem: $$\widehat{\beta}=\min\left\{\sum_{i=1}^{n}\left(y_i-\beta'x_i\right)^{2}\right\}$$

Now, suppose instead of the **conditional mean**, we are interested in estimating the **conditional median**, and our model is:  $$\text{Median}[y|x] = \beta'x$$ 
Then $\widehat{\beta}$ can be obtained by minimizing the following L1 error minimization problem: $$\widehat{\beta}=\min\left\{\sum_{i=1}^{n}\left|y_i-\beta'x_i\right|\right\}$$ This is called **least absolute deviation (LAD) regression**. 

More generally, let $Q_{\tau}(y)$ denote the $\tau-\text{th}$ quantile of $y$ (e.g., $Q_{\frac{1}{2}}(y)=\text{Median}(y)$). **Quantile regression** seeks to model the **conditional quantile** of $y$ given $x$. Suppose $$Q_{\tau}(y|x) = \beta'x$$ Then we can estimate $\beta$ by minimizing the following problem: $$\widehat{\beta}=\min\left\{ \sum_{i=1}^{n}\rho_{\tau}\left(y_{i}-\beta'x_{i}\right)\right\}$$, where the **loss function** $\rho_{\tau}(.)$ is defined as $$\rho_{\tau}\left(e\right)=e\left(\tau-\mathcal{I}\left(e<0\right)\right)$$

## Tasks
1. Write a formal introduction to quantile regression
    - Optional: How to solve the quantile loss minimization problem by linear programming
3. Empirical implementation of quantile regression using real or simulated data (real data with real economic problems preferred) [^1]

[^1]: Use any statistical computing language that you like, e.g., Stata, R, Matlab, Python

## Suggested Readings ([link](https://github.com/jiamingmao/data-analysis/tree/master/Materials/Regression) to papers)

- Nguyen, [Quantile Regression](https://bookdown.org/mike/data_analysis/quantile-regression.html)
- Koenker, R. And K. Hallock. (2001) "Quantile Regression," *Journal of Economic Perspectives*, 15(4).
- Koenker, R. (2017) "Quantile Regression 40 Years On," *Annual Review of Economics*, 9.

