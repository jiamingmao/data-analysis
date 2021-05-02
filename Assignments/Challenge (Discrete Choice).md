# Classification and Discrete Choice Models
# Homework Challenge: Discrete Game (2 Extra Points)

In the random utility framework, we model individual choice as individual i choosing among K choices by maximizing her utility U(i,k), with U(i,k) being a function of observed individual and alternative characteristics x(i,k).

Now imagine you are studying a problem in which several individuals make desions *simulataneously* and each individual's utility depends not only on x(i,k), but also on what other individuals will do.

Example 1: movie release date. When a film studio is deciding on the release date of a movie, it has to consider not only consumer demand (e.g., demand is higher in the summer or around big holidays), but also what its competitors will do (e.g., I want to release my movie in April, but what if Disney drops its Avengers in April as well?). For an analysis of this problem, see [Einav (2010)](https://github.com/jiamingmao/data-analysis/tree/master/Materials/Classification%20and%20Discrete%20Choice%20Models).

Example 2: firm entry. When a firm decides whether to enter a particular market, it has to consider not only the characteristics of the market, but also whether its competitors will enter the market too. (e.g., when K-mart decides whether to open a store in a small town, it has to consider whether Walmart will do so as well. When Macy's decides whether to enter a market, it has to consider the decisions of other department stores like Nordstrom as well). See [Jia (2008)](https://github.com/jiamingmao/data-analysis/tree/master/Materials/Classification%20and%20Discrete%20Choice%20Models) for an analysis of supermarket entry decisions and [Vitorino (2012)](https://github.com/jiamingmao/data-analysis/tree/master/Materials/Classification%20and%20Discrete%20Choice%20Models) for an analysis of shopping center entry decisions. 

In these cases, individual choices involve **strategic interactions**, which we can model using **game theory**. Each individual's choice can be considered the result of an **equilibrium strategy**. The resulting model is called a **discrete game** model.

Of course, in practice, individuals (including households, firms, and governments) often do not make decisions simultaneously. Many type of decisions also need to be made repeatedly. When we model strategic choices as being made only once and simultaneously, we have a **static game** model, while strategic choices made over many periods are called **dynamic games**.

## Challenge

Can you think of a way to model this type of strategic interactions in discrete choice problems?

Challenge: 

1. Write an introduction on *static discrete game*. In particular, what are games of complete and incomplete information? What are the relevant equilibrium concepts? 
2. Do a simple static discrete game model with complete or incomplete information involving several players and estimate their utility parameters from data (feel free to simulate the data yourself).

## Reference

Estimation of games is a type of **structural estimation**, and has been a big topic in *empirical industrial organization*.

While there is a long list of literature, you can find a simple introduction to the estimation of static games in [Ellickson & Misra (2011)](https://github.com/jiamingmao/data-analysis/tree/master/Materials/Classification%20and%20Discrete%20Choice%20Models). 

