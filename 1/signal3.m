clear; % 清除内存中可能保留的MATLAB变量

N = 50000; % 噪声信号的长度
power_target = 0.02; % 目标功率

g1 = rand(1,N); % 生成均匀分布的伪随机数，即白噪声
g_mean_org = mean(g1); % 计算原始均值
disp(['原始均值: ', num2str(g_mean_org)]);

% 计算实际生成的g的方差
actual_power = var(g1);
disp(['原始方差: ', num2str(actual_power)]);

% 计算缩放因子
scale_factor = sqrt(power_target / actual_power);

% 生成白噪声，注意力求均值为0，功率为0.02
g = (rand(1, N) - g_mean_org) * scale_factor;

g_mean = mean(g); % 计算均值
power_g = var(g); % 计算方差

subplot(211); % 在一个图上分成上、下两个子图
plot(g(1:100)); % 绘制信号中的前100个点
grid on; % 给图形加上网格
ylabel('g(n)'); % 给y轴加标注
xlabel('n'); % 给x轴加标注

subplot(212);
hist(g, 50); % 基于向量g中的元素创建直方图
grid on;
ylabel('histogram of g(n)');

disp(['均值: ', num2str(g_mean)]);
disp(['方差: ', num2str(power_g)]);
