clc
clear
% 读取心电数据
fileName = 'powerInterference.xls';
temp = xlsread(fileName);
x = temp(:, 5); % 含有工频干扰的心电信号

% ① 显示信号的波形
figure;
t = (0:length(x)-1) / 500; % 时间轴，采样频率为500Hz
% subplot(3,1,1);
% plot(t, x);
% title('原始信号波形');
% xlabel('Time (s)');
% ylabel('Amplitude');
% grid on;

% ② 绘制信号的幅度谱
% subplot(3,1,2);
X = fft(x);
f = (0:length(X)-1) * 500 / length(X); % 频率轴
% plot(f, abs(X));
% title('原始信号幅度谱');
% xlabel('Frequency (Hz)');
% ylabel('Magnitude');
% grid on;

% ③ 减去均值后绘制幅度谱
x_mean_removed = x - mean(x);
% subplot(3,1,3);
X_mean_removed = fft(x_mean_removed);
% plot(f, abs(X_mean_removed));
% title('去除均值后的幅度谱');
% xlabel('Frequency (Hz)');
% ylabel('Magnitude');
% grid on;

% ④ 对比两幅幅度谱，找出差异
plot(f, abs(X), 'b', f, abs(X_mean_removed), 'r');
legend('原始信号', '去除均值后');
title('对比两幅幅度谱');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;
