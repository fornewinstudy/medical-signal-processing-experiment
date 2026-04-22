clc;
clear all;
n = 0:49;
x1n = n+1;
n = 50:99;
x2n = 100-n;
xn = [x1n,x2n];
N = 100;
n = 0:99;
[XK,w] = dtft(xn,n,N);
yn = ifft(XK)
max(abs(xn-yn))




