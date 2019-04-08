####################
## Neural Networks #
####################
## Code to accompany Lecture on 
## Neural Networks
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io

rm(list=ls())
set.seed (1)
library(nnet)

set.seed(100)
n = 1000 
x = matrix(rnorm(n*2),ncol=2) 
x[1:n/2,] = x[1:n/2,] + 2 
x[(n/2+1):(n/4*3),] = x[(n/2+1):(n/4*3),] - 2 
y = c(rep(1,(n/4*3)),rep(2,(n/4)))

# Create training and test sets
data = data.frame(x1=x[,1],x2=x[,2],y=as.factor(y))
train = sample(n,n*0.4) 
data_train = data[train,] 
data_test = data[-train,] 

# Plot data
plot(data_train$x1,data_train$x2,col=data_train$y,xlab="x1",ylab="x2",cex.lab=1.25)
  
# Neural networks
set.seed(100)
fit = nnet(y~.,data=data_train,size=10,decay=0.1)

# test err
ytrue = data_test[,"y"]
yhat = predict(fit,data_test,type="class") 
table(ytrue,yhat) 
err = 1-mean(yhat==ytrue)
err