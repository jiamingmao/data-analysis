%% Lasso
%{
    Author: Jiaming Mao (jiaming.i.mao@gmail.com)
%}
ccc;
rng default
N = 200; K = 90; 
X = [ones(N,1), randn(N,K-1)];
b0 = 1 + randn(K,1);
b0(rand(K,1) < .7) = 0;
Y = X*b0 + randn(N,1);

%% Estimation
tr = rand(N,1) < .5; 
Xtr = X(tr,:); Ytr = Y(tr,:); % training 
Xho = X(~tr,:); Yho = Y(~tr,:); % hold out

% OLS
r.ols = fitlm(Xtr,Ytr,'intercept',false);
b.ols.all = r.ols.Coefficients.Estimate;
b.ols.sig = b.ols.all;
b.ols.sig(r.ols.Coefficients.pValue < .05) = 0;

% Lasso
[r.lasso,info] = lasso(Xtr(:,2:end),Ytr,'CV',10);
lassoPlot(r.lasso,info,'PlotType','CV');
b.lasso = [info.Intercept(info.Index1SE); r.lasso(:,info.Index1SE)];

disp('non-zero coefficients: b0,ols(sig),lasso')
[sum(b0~=0) sum(b.ols.sig~=0) sum(b.lasso~=0)] %#ok<*NOPTS>

figure; histogram(b0,20); hold on
histogram(b.ols.all,20); histogram(b.ols.sig,20);
histogram(b.lasso,20); legend('b0','ols','ols(sig)','lasso');

figure; scatter(b0,b.ols.all); hold on; scatter(b0,b.ols.sig); 
scatter(b0,b.lasso); refline(1,0);
legend({'ols','ols(sig)','lasso'},'Location','NorthWest'); xlabel('b0')

%% Evaluating on holdout sample
yhat.ols.all = Xho*b.ols.all;
yhat.ols.sig = Xho*b.ols.sig;
yhat.lasso = Xho*b.lasso;

disp('test error: ols,ols(sig),lasso')
[norm(Yho - yhat.ols.all) norm(Yho - yhat.ols.sig) norm(Yho - yhat.lasso)]
