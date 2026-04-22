% 读入数据
load('ALine.mat');

% 采样频率为40 MHz
fs = 40e6;

% ① 显示超声信号
time_us = (0:length(x)-1) / fs * 1e6; % 时间轴，单位为微秒
figure;
subplot(3,1,1);
plot(time_us, x);
title('超声信号波形');
xlabel('Time (\mu s)');
ylabel('Amplitude');
grid on;

% ② 绘制归一化幅度谱
f_MHz = (-fs/2:fs/length(x):fs/2-fs/length(x))/1e6; % 频率轴，单位为MHz
AFreq = fftshift(fft(x) / length(x));
subplot(3,1,2);
plot(f_MHz, abs(AFreq));
title('归一化幅度谱');
xlabel('Frequency (MHz)');
ylabel('Normalized Magnitude');
grid on;

% ③ 绘制幅度谱（以dB为单位）
AFreq_dB = 20*log10(abs(AFreq));
subplot(3,1,3);
plot(f_MHz, AFreq_dB);
title('幅度谱');
xlabel('Frequency (MHz)');
ylabel('Magnitude (dB)');
grid on;
