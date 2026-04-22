clear all;
clc;
%设计低通滤波器，采用汉明窗
wp = 0.2*pi;
ws = 0.3*pi;
tr_width = ws - wp;
N = ceil(6.6*pi/tr_width)+1
n = 0:N-1;
wc = (wp+ws)/2;
hd = ideal_lp(wc,N);%理想低通滤波器
w_ham = (hamming(N))';%汉明窗
h = hd.*w_ham;%加窗

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
stem(n,w_ham);
subplot(2,2,3);
stem(n,h);
subplot(2,2,4);
plot(w/pi,db);
grid
