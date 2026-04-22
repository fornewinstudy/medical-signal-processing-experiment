% 参数设置
f1 = 2;    % Hz
f2 = 2.02; % Hz
f3 = 2.07; % Hz
fs = 10;   % 采样频率 Hz

% 信号生成
t = 0:1/fs:1;  % 时间范围
x = sin(2*pi*f1*t) + sin(2*pi*f2*t) + sin(2*pi*f3*t);

% 进行频谱分析
N = length(x);        % 信号长度
frequencies = (0:N-1) * fs / N;  % 计算频率轴

% 计算幅度谱
X = abs(fft(x));

% 绘制频谱图
figure;
plot(frequencies, X);
title('信号频谱分析');
xlabel('频率 (Hz)');
ylabel('幅度');

% 估计频谱分辨率
delta_f = fs / N;
disp(['频谱分辨率: ', num2str(delta_f), ' Hz']);

% 确定数据长度
required_resolution = 2.07 - 2;  % 需要分辨的频率范围
required_N = fs / required_resolution;
disp(['为了分辨 2.07Hz 和 2Hz，数据长度 N 应大于 ', num2str(required_N)]);
