clear; % 清除内存中可能保留的MATLAB变量

N = 50000; % 噪声信号的长度
power_target = 0.3; % 目标功率

g1 = randn(1, N);
g_mean_org = mean(g1); % 计算原始均值
disp(['原始均值: ', num2str(g_mean_org)]);

% 调整信号的方差以满足目标功率
std_deviation = sqrt(power_target);

% 生成白噪声，均值为0,功率为0.3
g = (randn(1, N) - g_mean_org) * std_deviation;

g_mean = mean(g); % 计算均值
power_g = var(g); % 计算方差

% 绘制信号的前500个点
subplot(211);
plot(g(1:500));
grid on;
ylabel('g(n)');
xlabel('n');
title('前500个点的信号');

% 绘制信号的直方图
subplot(212);
hist(g, 50); % 基于向量g中的元素创建直方图
grid on;
ylabel('直方图');
title('信号直方图');

disp(['均值: ', num2str(g_mean)]);
disp(['功率: ', num2str(power_g)]);