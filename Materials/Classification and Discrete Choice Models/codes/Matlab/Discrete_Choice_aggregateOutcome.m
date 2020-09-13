%% Discrete Choice Model of Aggregate Binary Outcomes
%{
    There are m locations with each characteristics X(m)
    In each location, n individuals choose y in {1,2} based on X(m) and
    idiosyncratic shocks

    Author: Jiaming Mao 
    https://jiamingmao.github.io/data-analysis/
%}

%% simulation
ccc;
m = 1000; n = 20; N = n + zeros(m,1); %N: m-by-1; N=[n n ... n]'
nchoice = 2; 
x = rand(m,1); 
beta = [0;10] %#ok<*NOPTS>
X = [ones(m,1) x]; 
eu = zeros(m,1,nchoice); eu(:,:,2) = X*beta; %expected utility; m-by-1-by-nchoice
%   eu(:,:,1) = 0
%   eu(:,:,2) = X*beta  
e = randraw('extrvalue',[0 1],[m n nchoice]); %m-by-n-by-nchoice idiosyncratic shocks
u = bsxfun(@plus,eu,e); %utility; m-by-n-by-nchoice
[~,choice] = max(u,[],3); %m-by-n
y = sum(choice==2,2); %m-by-1; total number of choice==2 in each m
p = y/n; %percentage of choice==2; m-by-1 

%% visualize data
tx = linspace(0,1,100)'; xx = [ones(100,1) tx]; 
px = exp(xx*beta)./(1+exp(xx*beta)); %theoretical probability
scatterhist(x,p,'Marker','.'); hold on
plot(tx,px,'LineWidth',2)

%% estimation
%  method 1
px = @(b) exp(X*b(:))./(1+exp(X*b(:))); %m-by-1 cultivating probability
ll = @(b) sum(log(binopdf(y,N,px(b)))); nll = @(b) -ll(b); %negative log likelihood
b0 = [0;1]; lb = [-1e3;-1e3]; ub = [1e3;1e3];
b1 = fmincon(nll,b0,[],[],[],[],lb,ub,[],optimset('Display','off'))

%  method 2
b2 = glmfit(x,[y N],'binomial')

% method 3
ind = p>0 & p<1;
z = log(p(ind)) - log(1-p(ind));
b3 = X(ind,:)\z

% method 4
eps = 1e-4;
p(p==1) = p(p==1) - eps;
p(p==0) = p(p==0) + eps;
z = log(p) - log(1-p);
b4 = X\z
