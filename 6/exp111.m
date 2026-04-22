clc
clear
% 1. 对每一个T画出x(n)
T1 = 0.05;  % 采样间隔
t1 = 0:T1:1;  % 时间范围
x1 = sin(2*pi*t1);

% 绘制采样样本
figure;
stem(t1, x1, 'r', 'LineWidth', 2);
title('离散采样信号 x(n) (T=0.05秒)');
xlabel('时间 (秒)');
ylabel('幅度');
grid on;

% 2. 采用 sinc 函数内插（用 dt = 0.001）从样本 x(n) 重建模拟信号
dt = 0.001;  % 插值步长
t_interp1 = 0:dt:1;  % 插值时间范围
x_interp1 = zeros(size(t_interp1));

for i = 1:length(t_interp1)
    x_interp1(i) = sum(x1 .* sinc((t_interp1(i) - t1) / T1));
end

figure;
plot(t1, x1, 'r', 'LineWidth', 2, 'DisplayName', '原始信号');
hold on;
plot(t_interp1, x_interp1, 'b--', 'LineWidth', 1.5, 'DisplayName', '重建信号');
title('原始信号与重建信号比较 (T=0.05秒)');
xlabel('时间 (秒)');
ylabel('幅度');
legend('show');
grid on;

% 统计出重建信号与原信号的最大差异
max_diff1 = max(abs(x_interp1 - sin(2*pi*t_interp1)));

fprintf('最大差异（T=0.05秒）: %f\n', max_diff1);

% 3. 选用采样间隔 T=0.1 秒，重做该题
T2 = 0.1;  % 新的采样间隔
t2 = 0:T2:1;  % 新的时间范围
x2 = sin(2*pi*t2);

% 绘制采样样本
figure;
stem(t2, x2, 'b', 'LineWidth', 2);
title('离散采样信号 x(n) (T=0.1秒)');
xlabel('时间 (秒)');
ylabel('幅度');
grid on;

% 采用 sinc 函数内插（用 dt = 0.001）从样本 x(n) 重建模拟信号
x_interp2 = zeros(size(t_interp1));

for i = 1:length(t_interp1)
    x_interp2(i) = sum(x2 .* sinc((t_interp1(i) - t2) / T2));
end

figure;
plot(t2, x2, 'r', 'LineWidth', 2, 'DisplayName', '原始信号');
hold on;
plot(t_interp1, x_interp2, 'b--', 'LineWidth', 1.5, 'DisplayName', '重建信号');
title('原始信号与重建信号比较 (T=0.1秒)');
xlabel('时间 (秒)');
ylabel('幅度');
legend('show');
grid on;

% 统计出重建信号与原信号的最大差异
max_diff2 = max(abs(x_interp2 - sin(2*pi*t_interp1)));

fprintf('最大差异（T=0.1秒）: %f\n', max_diff2);
