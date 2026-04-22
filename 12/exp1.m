clc;
clear;

% 新的阻带和通带截止频率
wp = 0.3*pi; % 通带截止频率
ws = 0.2*pi; % 阻带截止频率
As = 40;     % 阻带最小衰减
Rp = 1;      % 通带最大波纹

% 滤波器设计参数
tr_width = wp - ws;
N = ceil((As-7.95)/(2.285*tr_width)+1)+1; % 滤波器阶数
n = 0:N-1;
beta = 0.1102*(As-8.7);
wc = (wp+ws)/2; % 截止频率

% 生成高通滤波器的理想冲击响应
hd = ideal_hp(wc,N);

% 应用窗函数
w_kai = (kaiser(N,beta))';
h = hd.*w_kai;

% 频率响应
[H,w] = freqz(h,1,1000,'whole');
delta_w = 2*pi/1000;
H = (H(1:501))';
w = (w(1:501))';
mag = abs(H);
db = 20*log10((mag+eps)/max(mag));

% 评估滤波器性能
Rp_max = -min(db(wp/delta_w+1:1:501)); % 通带最大衰减
As_min = -max(db(1:1:ws/delta_w));    % 阻带最小衰减

disp(['阻带最小衰减 As = ', num2str(As_min), ' dB']);
disp(['通带最大衰减 Rp = ', num2str(Rp_max), ' dB']);

% 绘图
subplot(2,2,1);
stem(n,hd);
title('理想高通滤波器冲击响应');

subplot(2,2,2);
stem(n,w_kai);
title('Kaiser窗');

subplot(2,2,3);
stem(n,h);
title('实际滤波器冲击响应');

subplot(2,2,4);
plot(w/pi,db);
title('幅度响应');
grid;

% 理想高通滤波器函数
function hd = ideal_hp(wc, N)
    alpha = (N-1)/2;
    n = 0:N-1;
    m = n - alpha;
    fc = wc / pi;
    hd = sinc(m) - fc * sinc(fc * m);
end