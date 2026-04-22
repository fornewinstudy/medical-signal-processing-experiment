% 定义连续时间信号 x(t)
f0 = 20; % 信号频率 20 Hz
fs = 1000; % 采样频率 1000 Hz
t = 0:1/fs:5; % 采集5秒的数据
x = sin(2 * pi * f0 * t);

% 添加高斯分布的噪声
SNR_dB = -10; % 信噪比为-10dB
SNR_linear = 10^(SNR_dB / 10);
noise_power = var(x) / SNR_linear;
g = rand(1,length(t)); % 产生均匀分布的白噪声信号
g = g - mean(g); % 标准化
power_g = var(g); %计算方差
g = sqrt(noise_power/power_g) * g;

% 创建数字信号 y(t)
y = x + g;

% 绘制连续时间信号 x(t)
subplot(2, 1, 1);
plot(t, x);
title('Signal x(t)');
xlabel('t (seconds)');

% 绘制数字信号 y(t)
subplot(2, 1, 2);
plot(t, y);
title('Signal y(t)');
xlabel('t (seconds)');
