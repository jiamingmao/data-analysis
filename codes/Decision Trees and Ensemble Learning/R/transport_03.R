###################
## Transportation #
###################
## Code to accompany Lecture on 
## Tree-based Methods
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io

rm(list = ls())
library(rpart)
library(rpart.plot)

## reading data
transport = read.csv("Transport.txt")
names(transport) = c("loginc","distance","mode")

#######################
# Classification Tree #
#######################
set.seed(100)
fit0 = rpart(mode~.,transport,
             control=rpart.control(cp=0))
printcp(fit0)
plotcp(fit0)
fit = prune(fit0,
            cp=fit0$cptable[which.min(fit0$cptable[,"xerror"]),"CP"])
rpart.plot(fit,box.palette=list("Blues", "Oranges", "Greens"))
