% 生成正弦信号 x(n) = sin(0.25*pi*n)
n = 0:499;
x = sin(0.25 * pi * n);

% 计算信号x(n)的均值和方差
x_mean = mean(x);
x_var = var(x);
disp(['x(n)均值: ', num2str(x_mean)]);
disp(['x(n)方差: ', num2str(x_var)]);

% 添加均匀分布的噪声
SNR_dB = -3; % 信噪比为-3dB
SNR_linear = 10^(SNR_dB / 10); % 将dB表示的SNR转换为线性尺度
noise_power = x_var / SNR_linear;
g = rand(1,length(n)); % 产生均匀分布的白噪声信号
g = g - mean(g); % 标准化
power_g = var(g); %计算方差
g = sqrt(noise_power/power_g) * g;

% 创建信号 y(n)
y = x + g;

% 绘制信号 x(n)
subplot(2, 2, 1);
stem(n, x, 'filled');
title('Signal x(n) (stem)');
xlabel('n');
ylabel('x(n)');

% 绘制信号 y(n)
subplot(2, 2, 2);
stem(n, y, 'filled');
title('Signal y(n) (stem)');
xlabel('n');
ylabel('y(n)');

% 绘制信号 x(n) 使用plot
subplot(2, 2, 3);
plot(n, x, 'r');
title('Signal x(n) (plot)');
xlabel('n');
ylabel('x(n)');

% 绘制信号 y(n) 使用plot
subplot(2, 2, 4);
plot(n, y, 'b');
title('Signal y(n) (plot)');
xlabel('n');
ylabel('y(n)');
