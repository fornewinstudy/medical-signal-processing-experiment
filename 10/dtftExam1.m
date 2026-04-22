clc;
clear;
M = 51;%101
n = 0:M-1;
hann = 0.5*(1-cos(2*pi*n/(M-1)));%hanning window
N = 1000;
[XK,w] = dtft(hann,n,N);
subplot(2,1,1);
stem(n,hann);
subplot(2,1,2);
plot(w/pi,abs(XK));