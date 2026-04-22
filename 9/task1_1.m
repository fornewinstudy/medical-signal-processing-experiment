% 定义模拟信号
t = 0:0.01:1; % 时间范围为1秒，采样频率100Hz
xa_t = 2*sin(4*pi*t) + 5*cos(8*pi*t);

% 选择不同的N值
N_values = [40, 50, 60];

% 显示不同N值下的DFT谱
figure;

for i = 1:length(N_values)
    N = N_values(i);
    Fs = 100; % 采样频率为100Hz
    n = 0:N-1;
    xn = 2*sin(4*pi*n/Fs) + 5*cos(8*pi*n/Fs);

    % 计算N点DFT
    Xk = fft(xn, N);

    % 计算频率轴
    f = Fs*(0:N-1)/N;

    % 显示DFT谱的绝对值
    subplot(length(N_values), 1, i);
    stem(f, abs(Xk));
    title(['DFT Spectrum (N = ' num2str(N) ')']);
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    grid on;
end
