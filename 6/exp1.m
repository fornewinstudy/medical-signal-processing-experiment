% 1. 对每一个 T 画出样本
T = 0.05; % 采样间隔，单位：秒
t_original = 0:0.001:1; % 假设原始信号在 [0, 1] 秒范围内
original_signal = sin(2*pi*5*t_original); % 5 Hz正弦波作为示例

% 等间隔采样
t_sampled = 0:T:1;
sampled_signal = sin(2*pi*5*t_sampled);

% 绘制样本
figure;
subplot(3, 1, 1);
plot(t_original, original_signal, 'b', 'LineWidth', 2);
hold on;
stem(t_sampled, sampled_signal, 'r', 'LineWidth', 1);
title('Sampled Signal');
legend('Original Signal', 'Sampled Signal');

% 2. 使用函数内插重建模拟信号
reconstructed_signal = interp1(t_sampled, sampled_signal, t_original, 'linear');

% 绘制重建信号与原信号的差异
subplot(3, 1, 2);
plot(t_original, original_signal, 'b', 'LineWidth', 2);
hold on;
plot(t_original, reconstructed_signal, 'g--', 'LineWidth', 1);
title('Reconstructed Signal');
legend('Original Signal', 'Reconstructed Signal');

% 计算最大差异
max_difference = max(abs(original_signal - reconstructed_signal));
fprintf('最大差异：%f\n', max_difference);

% 3. 选用采样间隔 T_new 重新进行操作
T_new = 0.1;
t_sampled_new = 0:T_new:1;
sampled_signal_new = sin(2*pi*5*t_sampled_new);

% 重建新信号
reconstructed_signal_new = interp1(t_sampled_new, sampled_signal_new, t_original, 'linear');

% 绘制新样本和重建信号与原信号的对比
subplot(3, 1, 3);
plot(t_original, original_signal, 'b', 'LineWidth', 2);
hold on;
stem(t_sampled_new, sampled_signal_new, 'r', 'LineWidth', 1);
plot(t_original, reconstructed_signal_new, 'g--', 'LineWidth', 1);
title('New Sampled and Reconstructed Signal');
legend('Original Signal', 'New Sampled Signal', 'Reconstructed Signal');

% 计算新的最大差异
max_difference_new = max(abs(original_signal - reconstructed_signal_new));
fprintf('新的最大差异：%f\n', max_difference_new);
