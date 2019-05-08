%#############
%# Bootstrap #
%#############
% author: Zihan Zhang (zihan0203@gmail.com)
% https://landbuland.github.io

clc; clear
data = table2array(readtable('Portfolio.csv')); 
B = 1000;
A = zeros(B,1);
for i = 1:B
    index = randi(length(data),[1 length(data)]);
    x = data(index,1);
    y = data(index,2);
    c = cov(x,y);
    alpha = ((var(y)-c(1,2))/(var(x)+var(y)-2*c(1,2)));
    A(i) = alpha;
end

mu = mean(A) %#ok<*NOPTS>
sd = std(A)