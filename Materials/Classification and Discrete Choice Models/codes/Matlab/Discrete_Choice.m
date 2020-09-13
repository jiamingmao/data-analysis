%% Discrete Choice Model with Gumbel distributed errors
%{
    Author: Jiaming Mao 
    https://jiamingmao.github.io/data-analysis/
%}

%% simulation
ccc;
n = 10000;
x = rand(n,1);
beta = [0;2] %#ok<*NOPTS>
X = [ones(n,1) x]; 
eu = [zeros(n,1) X*beta]; %expected utility; n-by-nchoice
e = randraw('extrvalue',[0 1],[n 2]); %n-by-nchoice idiosyncratic shocks
u = eu + e;
[~,y] = max(u,[],2); %m-by-n
y = y - 1;

%% estimation
b = glmfit(x,y,'binomial')
