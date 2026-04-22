clear all;
clc;
%设计带通滤波器，采用Blackman窗
%阻带最小衰减74dB
ws1 = 0.2*pi;
wp1 = 0.35*pi;
wp2 = 0.65*pi;
ws2 = 0.8*pi;
As = 60;
tr_width = min((wp1-ws1),(ws2-wp2));
N = ceil(11*pi/tr_width)+1
n = 0:N-1;
%beta = 0.1102*(As-8.7);
wc1 = (wp1+ws1)/2;
wc2 = (wp2+ws2)/2;
hd = ideal_lp(wc2,N)-ideal_lp(wc1,N);
w_bla = (blackman(N))';
h = hd.*w_bla;

[H,w] = freqz(h,1,1000,'whole');
delta_w = 2*pi/1000;
H = (H(1:501))';
w = (w(1:501))';
mag = abs(H);
db = 20*log10((mag+eps)/max(mag));
Rp = -(min(db(wp1/delta_w+1:1:wp2/delta_w)))
As = - round(max(db(ws2/delta_w+1:1:501)))
subplot(2,2,1);
stem(n,hd);
subplot(2,2,2);
stem(n,w_bla);
subplot(2,2,3);
stem(n,h);
subplot(2,2,4);
plot(w/pi,db);
grid