function [ m, s ] = mean_squre_error(errArray)
%MEAN_SQURE_ERROR Summary of this function goes here
%   Detailed explanation goes here
l = cell(5,1);
r = zeros(5,1);
for i = 1:5
    t = errArray{i,1}.trueCount;
    l{i} = errArray{i,1}.estCount;
    r(i) = mse(l{i},t);
end
m = mean(r);
s = std(r);
end

