###########################
## Census Wage Regression #
###########################
## Code to accompany Lecture on 
## Regression
## Jiaming Mao (jmao@xmu.edu.cn)
## https://jiamingmao.github.io

## read and select sample data
census <- read.csv("census2000.csv")
workers <- (census$hours > 500)&(census$income > 5000)&(census$age < 60) 
log.WR <- log(census$income/census$hours)[workers]
age <- census$age[workers]
sex <- census$sex[workers]

## summarize wage by age and gender
men <- sex == "M"
malemean <- tapply(log.WR[men], age[men], mean) #calculate mean wage at each age level
femalemean <- tapply(log.WR[!men], age[!men], mean)
plot(18:59, malemean, type="l", lwd=2, col=4, xlab="age",
     ylab="mean log wage",ylim=c(1.8,3))
lines(18:59, femalemean, lwd=2, col=6)
text(x = rep(60,2), y = c(malemean[42],femalemean[42]),
     labels=c("M","F"), col=c(4,6))

## wage regression 1
wagereg1 <- lm(log.WR ~ age)
summary(wagereg1)
grid <- 18:59
plot(grid, wagereg1$coef[1] + wagereg1$coef[2]*grid, type="l", lwd=2,
     main="", xlab="age", ylab="mean log wage") 

## wage regression 2
wagereg2 <- lm(log.WR ~ age + sex)
summary(wagereg2)
plot(grid, wagereg2$coef[1] + wagereg2$coef[2]*grid +
     wagereg2$coef[3], type="l", lwd=2, col=4,
     main="", xlab="age", ylab="mean log wage", ylim=c(2,3.1)) 
lines(grid, wagereg2$coef[1] + wagereg2$coef[2]*grid, lwd=2, col=6)
legend("topleft", col=c(4,6), lwd=4, legend=c("M","F"), bty="n")

## wage regression 3
wagereg3 <- lm(log.WR ~ age*sex)
summary(wagereg3)
plot(grid, wagereg3$coef[1] + (wagereg3$coef[2]+wagereg3$coef[4])*grid +
     wagereg3$coef[3], type="l", lwd=2, col=4, main="", xlab="age",
     ylab="mean log wage", ylim=c(2.2,3.2)) 
lines(grid, wagereg3$coef[1] + wagereg3$coef[2]*grid, lwd=2, col=6)
legend("topleft", col=c(4,6), lwd=4, legend=c("M","F"), bty="n")

## wage regression 4
age2 <- age*age
wagereg4 <- lm(log.WR ~ age*sex + age2)
summary(wagereg4)
plot(grid, wagereg4$coef[1] + (wagereg4$coef[2]+wagereg4$coef[5])*grid +
     wagereg4$coef[3] + wagereg4$coef[4]*grid^2 ,
     type="l", lwd=2, col=4, main="", xlab="age",
     ylab="mean log wage", ylim=c(2,3)) 
lines(grid, wagereg4$coef[1] + wagereg4$coef[2]*grid +
      wagereg4$coef[4]*grid^2, lwd=2, col=6)
legend("topleft", col=c(4,6), lwd=4, legend=c("M","F"), bty="n")

## wage regression 5
wagereg5 <- lm(log.WR ~ age*sex + age2*sex)
summary(wagereg5)
plot(grid, wagereg5$coef[1] + (wagereg5$coef[2]+wagereg5$coef[5])*grid +
     wagereg5$coef[3] + (wagereg5$coef[4]+wagereg5$coef[6])*grid^2 ,
     type="l", lwd=2, col=4, main="", xlab="age", ylab="mean log wage", ylim=c(2,3)) 
lines(grid, wagereg5$coef[1] + wagereg5$coef[2]*grid +
      wagereg5$coef[4]*grid^2, lwd=2, col=6)
legend("topleft", col=c(4,6), lwd=2, legend=c("M fitted","F fitted"), bty="n")
lines(grid, malemean, col=4, lty=2)
lines(grid, femalemean, col=6, lty=2)
legend("bottomright", col=c(4,6), lwd=2, lty=2,
       legend=c("M data mean","F data mean"), bty="n")

