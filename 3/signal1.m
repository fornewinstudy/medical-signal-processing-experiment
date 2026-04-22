clc;
clear;
% 生成一个较长的输入序列
x_long = randn(1, 1000);

% 生成一个较短的滤波器系数序列
h_short = [1, 2, 3];

% 使用自己编写的重叠相加法函数计算卷积
y_overlap_add = overlapAddConvolution(x_long, h_short);

% 使用MATLAB内置函数计算卷积
y_builtin_conv = conv(x_long, h_short);

% 对比两种方法的卷积结果
diff = y_overlap_add - y_builtin_conv;

% 显示结果
subplot(3,1,1); plot(y_overlap_add);
title('Overlap-Add Convolution Result');
subplot(3,1,2); plot(y_builtin_conv);
title('MATLAB Convolution Result');
subplot(3,1,3); plot(diff);
ylim([-1e-13, 1e-13]); % 设置纵坐标范围为 -1e-13 到 1e-13
title('Difference');

function y = overlapAddConvolution(xn,hn)
N = length(hn); % 滤波器的长度
M = 5; % 输入信号的长度
L = M + N -1; % 选择FFT的长度，通常选择2的幂
xnn = [zeros(1, N-1), xn, zeros(1,M - mod(length(xn), M))]; % 前面补N-1个0，后面补0是为了使其能每段长度未M进行整段截取

block_num = floor(length(xn)/M); % 根据需要调整分段的大小
yn = zeros(1, (block_num+1)*M);

block_num = length(xn)/M;
% 分段计算卷积
for i = 1:block_num+1
    xn_ = xnn(((i-1)*M+1):((i-1)*M+L));
    hn_ = [hn, zeros(1, L-N)];

    yn_ = ifft(fft(xn_) .* fft(hn_));

    yn(((i-1) * M+1):((i-1)*M+M)) = yn_(N:L); % 保留与滤波器长度相同的部分
end
y = yn(1:length(xn)+length(hn)-1);
end