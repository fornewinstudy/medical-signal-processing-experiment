clear; % 清除内存中可能保留的MATLAB变量

N = 50000; % 信号长度
power_target = 0.3; % 目标功率

% 生成均值为0、方差为1的高斯分布随机数
g = randn(1, N);
% 调整信号的方差以满足目标功率
std_deviation = sqrt(power_target);
g = g * std_deviation ;

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

