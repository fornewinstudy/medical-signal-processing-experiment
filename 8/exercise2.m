f0 = 50;  % 信号频率
fs = 200; % 采样频率

% 采样点数分别为 8、10 和 80
n_points = [8, 10, 80];

figure;

for i = 1:length(n_points)
    N = n_points(i);
    Ts = 1 / fs; % 采样周期
    n = 0:N-1;   % 采样点序列

    x = sin(2*pi*f0*n*Ts);

    % 计算幅度谱
    X = abs(fft(x));

    % 频谱归一化
    freq = (0:N-1) * fs / N;

    % 绘制频谱
    subplot(length(n_points), 1, i);
    stem(freq, X);
    title(['频谱分析：', num2str(N), ' 个采样点']);
    xlabel('频率 (Hz)');
    ylabel('幅度');

    % 标签
    legend(['N = ', num2str(N)]);
end
