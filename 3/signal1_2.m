%{
fftfilt 函数是用于将滤波器应用于信号的 MATLAB 函数。
它使用FFT来计算卷积，因此通常比直接卷积更快，特别是对于长信号和长滤波器。
example:
y = fftfilt(b, x)
其中 b 是滤波器系数，x 是输入信号。fftfilt 函数将输入信号 x 与滤波器系数 b 卷积，并返回卷积结果 y。
%}
% Demo
% 生成输入信号和滤波器系数
x = randn(1, 1000);
b = [1, 2, 3];

% 使用 fftfilt 函数进行卷积
y = fftfilt(b, x);

% 显示卷积结果
plot(y);
title('fftfilt Convolution Result');
