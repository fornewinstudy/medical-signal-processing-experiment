clc;
clear all;
n = 0:49;
x1n = n+1;
n = 50:99;
x2n = 100-n;
xn = [x1n,x2n];
N = 10;
n = 0:99;
[XK,w] = dtft(xn,n,N);
yn = ifft(XK);

y2n= zeros(1,length(yn));
temp2 = zeros(1,length(yn));
y2n = xn(1:10);
for r = 1:9
    temp2 = xn(r*10+1:(r+1)*10);
    y2n = y2n+temp2;
end

max(abs(yn-y2n))

