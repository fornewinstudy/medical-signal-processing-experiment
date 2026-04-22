clear 
clc 
% 信号x(n)的定义
n = 0:15; % 创建一个从0到6的n的向量
x = zeros(size(n)); % 创建一个与n相同大小的零向量
x(n >= 0 & n <= 3) = n(n >= 0 & n <= 3) + 1; % 设置信号x(n)的值

% 绘制图形
% 时移
subplot(3, 1, 1);
stem(n, x);
title('x(n)');

subplot(3, 1, 2);
[x11,n11] = sigshift(x,n,-2);
stem(n11,x11);
title('x(n+2)');

subplot(3, 1, 3);
[x12,n12] = sigshift(x,n,3);
stem(n12,x12);
title('x(n-3)');

% 翻转
figure; % 新建一个图形窗口
subplot(2, 1, 1);
stem(n, x);
title('x(n)');

subplot(2, 1, 2);
[x2,n2] = sigfold(x,n);
stem(n2,x2);
title('x(-n)');

% 相加
figure; % 新建一个图形窗口
subplot(2, 2, 1);
stem(n, x);
title('x(n)');

subplot(2, 2, 2);
stem(n2,x2);
title('x(-n)');

subplot(2, 2, 3);
[xe,n3] = sigadd(x/2,n,x2/2,n2);
stem(n3, xe);
title('xe(n)');

subplot(2, 2, 4);
[xd,n31] = sigadd(x/2,n,-(x2/2),n2);
stem(n31, xd);
title('xd(n)');

% 信号平移函数
function [y,n] = sigshift(x, m, k)
    n = m + k;
    y = x;
end

% 信号翻转函数
function [y, n] = sigfold(x, n)
    y = fliplr(x);
    n = -fliplr(n);
end

% 信号相加函数
function [y, n] = sigadd(x1, n1, x2, n2)
    n = min(min(n1), min(n2)):max(max(n1), max(n2)); % 的持续时间
    y1 = zeros(1, length(n));
    y2 = y1;
    y1(find((n >= min(n1)) & (n <= max(n1)) == 1)) = x1;
    y2(find((n >= min(n2)) & (n <= max(n2)) == 1)) = x2;
    y = y1 + y2;
end
