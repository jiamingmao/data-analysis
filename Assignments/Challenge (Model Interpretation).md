# Homework Challenge (2 Extra Points)

Given a simple linear model: y = b1\*x1 + b2\*x2, we know how to interpret it: conditional on x2, each 1 unit increase in x1 is associated with b1 units increase in y.

But given a general nonlinear model: y = f(x1,x2), where f(.) can be anything -- a polynomial model, a cubic spline --, how do we interpret the model? What is the association between x1 and y conditional on x2?

A common misconception is that nonlinear models, in particular, *black box* models like boosted decision trees and neural networks, are only good for prediction and cannot be interpretted. This is incorrect. The good news is that we can indeed interpret them. Here is how: 

In fact, to find out the association ("the impact") of a variable x1 on y, given a model y = f(x1,x2,...), we can calculate dy/dx1, where d stands for partial derivative.

### Challenge:

#### Task 1
