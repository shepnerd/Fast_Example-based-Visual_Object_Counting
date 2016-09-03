function [ err ] = mse( x, y )
%MSE Summary of this function goes here
%   Detailed explanation goes here
err = mean((x-y).^2);

end

