clc
clear
n = 0:99; % 序列的范围

% 定义序列x(n)
xn = zeros(size(n));
xn(1:50) = n(1:50) + 1;
xn(51:100) = 100 - n(51:100);

% 计算X(e^(jw))的样本
N = 200; % 采样点数
% DTFT
[XK, w] = dtft(xn, n, N);

% 计算yn = ifft(XK)
yn = ifft(XK);

% y3(n) 
y3n = [xn,zeros(1,100)]; % y3(n)相当于x(n)从0到200采样

figure;
subplot(2,1,1);
stem(0:199, abs(yn));
title('yn');
subplot(2,1,2);
stem(0:199, abs(y3n));
title('y3n');

fprintf('yn与y3n的差异:%f\n', max(abs(yn-y3n)))

% 比较yn和y2(n)是否相等
isequal(yn, y3n)