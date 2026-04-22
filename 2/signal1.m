% 定义信号 x(n) 和 h(n)
x = [2, -4, 5, 3, -1, -2, 6];
h = [1, -1, 1, -1, 1];
% 创建一个时间轴
n_x = -3:3;
n_h = -1:3;

% 计算卷积 y(n)
[y,n_y] = conv_m(x,n_x,h,n_h);

% 绘制信号 x(n)
subplot(3, 1, 1);
stem(n_x, x);
title('Signal x(n)');
xlabel('n');
axis([min([n_x n_y]) max([n_x n_y]) min(x) max(x)]); % 横坐标对齐

% 绘制信号 h(n)
subplot(3, 1, 2);
stem(n_h, h);
title('Signal h(n)');
xlabel('n');
axis([min([n_x n_y]) max([n_x n_y]) min(h) max(h)]); % 横坐标对齐

% 绘制卷积结果 y(n)
subplot(3, 1, 3);
stem(n_y, y);
title('Signal y(n)');
xlabel('n');
axis([min([n_x n_y]) max([n_x n_y]) min(y) max(y)]); % 横坐标对齐

function [y, ny] = conv_m(x, nx,h, nh)
% Modified convolution routine for signal processing
%
% [y, ny] = conv_m(x, nx,h, nh)
% [y, ny] = convolution result
% [x, nx] = first signal
% [h, nh] = second signal
%
nyb = nx(1)+ nh(1); nye = nx(length(x)) + nh(length(h));
ny = [nyb:nye]; y = conv(x,h);
end
