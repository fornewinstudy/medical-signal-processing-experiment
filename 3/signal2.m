clc;
clear;
Nx = 32;
n = 1:Nx;
xn = sin(0.25*pi*n); % 发射信号

Ny = 1600;
ny = 1:Ny;
yn = zeros(1, Ny);
yn(1001:1000 + Nx) = xn;

subplot(211);
plot(n, xn);
axis([1, Ny, -2, 2]);
title('发射信号');

gn = 0.3 * randn(1, Ny);
yn = yn + gn; % 添加噪声得到回波信号

subplot(212);
plot(ny, yn);
axis([1, Ny, -2, 2]);
title('回波信号');

% 计算回波信号与发射信号的互相关
correlation = xcorr(yn, xn);

% 显示互相关结果
figure;
subplot(211);
plot(-Ny+1:Ny-1, correlation);
title('互相关结果');

% 寻找互相关峰值，定位回波信号的位置
[~, max_idx] = max(correlation);
position = max_idx - Ny + 1;

subplot(212);
plot(ny, yn);
hold on;
plot(position:position + Nx - 1, xn, 'r', 'LineWidth', 2);
axis([1, Ny, -2, 2]);
title('回波信号与定位结果');
legend('回波信号', '定位结果');
