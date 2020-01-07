%% Poisson and Log Normal Regression
%{
    Jiaming Mao (jiaming.mao@gmail.com)
    https://jiamingmao.github.io/data-analysis/
%}
clc; clear;
rng default
n = 1e4; % # of individuals 
x = rand(n,1);
X = [ones(n,1),x];
e = normrnd(0,1,n,1);
y = exp(1 + 2*x + e);
b1 = glmfit(x,y,'poisson','estdisp','on') %#ok<*NOPTS>
b2 = X\log(y)
v2hat = var(log(y) - X*b2);
b2a = b2; b2a(1) = b2(1) + 0.5*v2hat %adjusted beta
y1hat = exp(X*b1);
y2hat = exp(X*b2);
y2ahat = exp(X*b2 + 0.5*v2hat); %adjusted yhat
