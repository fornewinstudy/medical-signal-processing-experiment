wp = 0.3*pi; % 通带截止频率
ws = 0.2*pi; % 阻带截止频率
tr_width = ws-wp; % 过渡带宽
N = ceil(6.6*pi/tr_width) + 1;  % 根据过渡带宽度确定N值：海明窗的过渡带宽是6.6*pi/N，即d_width = 6.6*pi/N，这里求N需要ceil向上取整再+1
n = 0:N-1;
wc = (wp+ws)/2; % 求理想低通的截止频率：通带截止频率和阻带截止频率的平均值
hd = ideal_lp(wc,N);  % 求出理想的单位抽样响应hd(n)
h = hd.*(hamming(N)'); % 求出所涉及的FIR滤波器的单位抽样响应h
[db,mag,pha,grd,w] = freqz_m(h,[1]); % 计算频率响应，其中w是频谱上对应的频点，这行代码背下来。。。
% delta_w = 2*pi/1000;
% Rp = -(min(db(1:wp/delta_w+1))); % 求出实际的阻带衰减
% As = -round(max(db(ws/delta_w+1 : 501))); %
% 画出理想的单位抽样响应hd(n)
subplot(221)
stem(n,hd);
title('Ideal Impulse Response');axis([0 N-1 -0.1 0.3]);xlabel('n');ylabel('hd(n)');
% 画出海明窗
subplot(222)
stem(n,(hamming(N))');
title('Hamming Window');axis([0 N-1 0 1.1]);xlabel('n');ylabel('w(n)');
% 画出设计的FIR滤波器的单位抽样响应（理想单位抽样响应与海明窗相乘的结果）
subplot(223)
stem(n,h);
title('Actual Impulse Response');axis([0 N-1 -0.1 0.3]);xlabel('n');ylabel('h(n)');
% 画出每dB上的响应
subplot(224)
plot(w/pi,db);
title('Magnitude Response in dB');axis([0 1 -100 10]);xlabel('frequency/pi');ylabel('dB');
