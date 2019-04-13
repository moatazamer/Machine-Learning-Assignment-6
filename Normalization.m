function [ y ] = Normalization( x )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

y= (x-mean(x))/std(x);

end

