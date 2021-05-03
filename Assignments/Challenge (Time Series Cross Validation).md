# Model Selection and Regularization
# Homework Challenge: Cross Validation for Time Series Data (1 Extra Point)


The cross-validation procedure we have discussed is based on the assumption that each observation $(x_i,y_i)$ is drawn i.i.d. from an underlying population $p(x,y)$, i.e. our data set $\mathcal{D}=\left\{ \left(x_{1},y_{1}\right),\ldots,\left(x_{N},y_{N}\right)\right\}$ constitutes a *random sample*. This allows us to randomly partition the data into $K$ folds and treat each fold in turn as a validation set for models estimated on rest of the data. 

This would not be true in *structured problems* where $\left(x_{i},y_{i}\right)$ are not independent – for example, when we have time-series data $\mathcal{D}=\left\{ \left(x_{1},y_{1}\right),\ldots,\left(x_{T},y_{T}\right)\right\}$, where $\left(x_{t},y_{t}\right)$ can be correlated with $\left(x_{t-1},y_{t-1}\right)$ and $\left(x_{t+1},y_{t+1}\right)$

## Challenge

1. Write a tutorial on conducting cross-validation for time-series data.
2. Perform simulations to illustrate the workings of the method. 

## References

See [notes and resources](https://github.com/jiamingmao/data-analysis/blob/master/Materials/Model%20Selection%20and%20Regularization/notes%20and%20resources.md) for references on time series CV. 