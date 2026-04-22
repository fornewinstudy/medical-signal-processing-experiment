clc
clear
% 定义模拟信号
t = 0:0.01:1; % 时间范围为1秒，采样频率100Hz
xa_t = 2*sin(4*pi*t) + 5*cos(8*pi*t);

% 选择采样点并得到N点序列
N = 50; % 选择N值为50
Fs = 100; % 采样频率为100Hz
n = 0:N-1;
xn = 2*sin(4*pi*n/Fs) + 5*cos(8*pi*n/Fs);

% 计算N点DFT
Xk = fft(xn, N);

% 计算频率轴
f = Fs*(0:N-1)/N;

% 显示模拟信号波形
figure;
plot(t, xa_t);
title('Analog Signal Waveform');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% 画出DFT谱的绝对值
figure;
stem(f, abs(Xk));
title('DFT Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;
