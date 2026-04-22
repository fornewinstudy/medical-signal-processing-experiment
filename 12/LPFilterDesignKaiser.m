clear all;
clc;
%设计低通滤波器，采用Kaiser窗
wp = 0.2*pi;
ws = 0.3*pi;
As = 50;
tr_width = ws - wp;
N = ceil((As-7.95)/(2.285*tr_width)+1)+1
n = 0:N-1;
beta = 0.1102*(As-8.7);
wc = (wp+ws)/2;
hd = ideal_lp(wc,N);
w_kai = (kaiser(N,beta))';
h = hd.*w_kai;

[H,w] = freqz(h,1,1000,'whole');
delta_w = 2*pi/1000;
H = (H(1:501))';
w = (w(1:501))';
mag = abs(H);
db = 20*log10((mag+eps)/max(mag));
Rp = -(min(db(1:1:wp/delta_w+1)))
As = - round(max(db(ws/delta_w+1:1:501)))
subplot(2,2,1);
stem(n,hd);
subplot(2,2,2);
stem(n,w_kai);
subplot(2,2,3);
stem(n,h);
subplot(2,2,4);
plot(w/pi,db);
grid