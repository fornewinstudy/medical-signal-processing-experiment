clc;
clear all;
M =51;
n = 0:M-1;
bw = 0.42-0.5*cos(2*pi*n/(M-1))+0.08*cos(4*pi*n/(M-1));
stem(n,bw)