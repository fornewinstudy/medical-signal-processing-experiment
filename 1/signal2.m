clear;           %清除内存中可能保留的MATLAB变量
N = 50000;       % 噪声信号的长度
g = rand(1, N);  % 产生均匀分布的伪随机数，即白噪声，均值约为0.5
g_mean = mean(g);  % 计算均值
power_g = var(g);  % 计算方差

subplot(211);    % 在一个图上分成上、下两个子图
plot(g(1:100));  % 绘制信号中的前100个点
grid on;         % 给图形加上网格
ylabel('g(n)');  % 给y轴加标注
xlabel('n');     % 给x轴加标注

subplot(212);
hist(g, 50);  % 基于向量g中的元素创建直方图
grid on;
ylabel('histogram of g(n)');

disp(['均值: ', num2str(g_mean)]);
disp(['方差: ', num2str(power_g)]);
