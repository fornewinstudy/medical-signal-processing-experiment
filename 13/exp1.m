clc
clear

% 参数设定
fs = 10000; % 采样频率为10kHz
wp = 2 * pi * 2000; % 通带截止频率为2kHz
ws = 2 * pi * 3000; % 阻带起始频率为3kHz
As = 40; % 阻带衰减至少40dB

% 计算Kaiser窗参数
tr_width = ws - wp; % 过渡带宽度
M = ceil((As - 7.95) / (2.285 * tr_width/(fs/2))); % 滤波器的阶数
beta = 0.1102 * (As - 8.7); % Kaiser窗参数

% 计算滤波器系数
n = 0:M-1;
wc = (wp + ws) / 2; % 截止频率
%hd = sin(wc*(n - M/2)) ./ (pi * (n - M/2)); % 理想低通滤波器的脉冲响应
%hd(M/2 + 1) = wc / pi; % 防止除以0
hd = ideal_lp(wc,M);

w_kai = (kaiser(M, beta))'; % 得到Kaiser窗
h = hd .* w_kai; % 加窗
[db,mag,pha,grad,w] = freqz_m(h,[1]);
delta_w = 2*pi/1000;
As = -round(max(db(ws/delta_w+1:1:501)));

% 绘制脉冲响应和窗函数
subplot(2,2,1);
stem(n, hd);
title('理想脉冲响应');
xlabel('n');
ylabel('hd(n)');

subplot(2,2,2);
stem(n, w_kai);
title('Kaiser窗');
xlabel('n');
ylabel('w(n)');

subplot(2,2,3);
stem(n, h);
title('实际脉冲响应');
xlabel('n');
ylabel('h(n)');

% 绘制幅度响应
[H, f] = freqz(h, 1, 1024, fs);
H_db = 20 * log10(abs(H));
subplot(2,2,4);
plot(f/1000, H_db);
title('幅度响应');
xlabel('频率(kHz)');
ylabel('幅度(dB)');

% 测试滤波器性能
t = 0:1/fs:0.03-1/fs; % 时间向量
x = 10*sin(2*pi*1500*t) + sin(2*pi*3500*t); % 测试信号
y = filter(h, 1, x); % 应用滤波器

% 绘制滤波前后的信号
figure;
subplot(2,1,1);
plot(t, x);
title('滤波前的信号');
xlabel('时间 (s)');
ylabel('幅度');

subplot(2,1,2);
plot(t, y);
title('滤波后的信号');
xlabel('时间 (s)');
ylabel('幅度');

% 绘制滤波前后的幅度谱
X_magnitude = abs(fft(x));
Y_magnitude = abs(fft(y));
f_vector = (0:length(X_magnitude)-1) * (fs/length(X_magnitude)) / 1000; % 频率向量(kHz)

figure;
subplot(2,1,1);
plot(f_vector, 20*log10(X_magnitude));
title('滤波前信号的幅度谱');
xlabel('频率 (kHz)');
ylabel('幅度 (dB)');

subplot(2,1,2);
plot(f_vector, 20*log10(Y_magnitude));
title('滤波后信号的幅度谱');
xlabel('频率 (kHz)');
ylabel('幅度 (dB)');

function hd = ideal_lp(wc,M)
alpha = (M-1)/2; n = [0:1:(M-1)];
m = n - alpha; fc = wc/pi; hd = fc*sinc(fc*m);
end

function [db,mag,pha,grd,w] = freqz_m(b,a)
[H,w] = freqz(b,a,1000,'whole'); % 计算频率响应
H = (H(1:501)); w = (w(1:501)); % 提取0到pi弧度范围内的响应
mag = abs(H); % 计算绝对幅度
db = 20*log10((mag + eps)/max(mag)); % 计算分贝值，eps避免对数运算中的除零错误
pha = angle(H); % 计算相位
grd = grpdelay(b,a,w); % 计算群延迟
end