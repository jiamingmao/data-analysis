%% MLE
%{
    Jiaming Mao (jiaming.mao@gmail.com)
    https://jiamingmao.github.io/data-analysis/
%}

clc; clear;
n = 1e4;
x = 5*rand(n,1); e = normrnd(0,1.5,n,1); y = 0.5*x + e;
figure; scatterhist(x,y); %visualize data

% Estimation

%# method 1
b1 = mle(y,'pdf',@(y,beta,sigma) normpdf(y-beta*x,0,sigma),'start',[0,1]) %#ok<*NOPTS>

%# method 2
%{
        ll = -n*ln(sigma)-(1/2*sigma^2)*[(y-x*beta)'*(y-x*beta)];
        nll = -ll; %this is because fmincon minimizes the objective fcn
%}
nll = @(b) n*log(b(2)) + 1/(2*b(2)^2)*((y-x*b(1))'*(y-x*b(1))); %b=[beta,sigma]
b0 = [0,1]; lb = [-100,0]; opt = optimset('PlotFcns','optimplotfval');
b2 = fmincon(nll,b0,[],[],[],[],lb,[],[],opt) 