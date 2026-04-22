clc;
clear;

%对正弦信号加高斯噪声，SNR为-10dB,
%之后用自相关检测加噪后信号是否含周期信号,周期是多少？
fs = 1000;%采样频率1000Hz
t = 5;%5秒
T = 1/fs;%采样间隔
f0 = 20;%正弦信号频率20Hz
nT = 0:T:5;
xn = sin(2*pi*f0*nT);%采样
Px = sum(xn.*xn)/length(xn);%信号xn的平均功率
SNR = -10;%信噪比
Pg = Px/10.^(0.1*SNR);%噪声的平均功率
gn = sqrt(Pg)*randn(1,length(xn));%高斯噪声
yn = xn+gn;
ny = 1:5001;
subplot(3,1,1);
plot(xn);
title('原始信号 xn');
subplot(3,1,2)
plot(yn)
title('加噪声后的信号 yn');

[yn_flip,n_flip] = sigfold(yn,ny); % 信号取反
[result,rn] = my_conv(yn,ny,yn_flip,n_flip);  % 卷积，相关

subplot(3,1,3)
title('自相关函数');
plot(rn(4500:5500),result(4500:5500))  % 展示
