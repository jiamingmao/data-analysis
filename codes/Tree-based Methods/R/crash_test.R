###############
## Crash Test #
###############
## Code to accompany Lecture on 
## Tree-based Methods
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io

require(MASS)
require(tree)
data(mcycle) 
t <- tree(accel ~ times, data=mcycle)
plot(t,col="grey",lwd=2)
text(t,cex=1.5)
grid <- data.frame(times = seq(1,60,length=1000))
plot(mcycle,pch=21,bg="grey",cex=2,cex.lab=1.5)
lines(grid$times,predict(t,newdata=grid),col="red",lwd=3)