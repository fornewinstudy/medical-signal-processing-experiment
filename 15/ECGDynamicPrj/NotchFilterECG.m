function dataOut = NotchFilterECG(dataIn)
% 设计陷波器并去除心电工频干扰
%   输入参数dataIn为原始心电波形
%   输出参数dataOut为陷波器处理后的波形
%   COPYRIGHT 2018-2020 LEYUTEK. All rights reserved.

Fs = 500;    % 采样频率
T = 1 / Fs; % 采样间隔
Fc = 50;     % 陷波频率

alpha = -2 * cos(2 * pi * Fc * T);         
beta  = 0.96;
b = [1, alpha, 1];
a = [1, alpha * beta, beta^2];

dataOut = filter(b, a, dataIn);

% fmaxd=5;%截止频率为3Hz
% fmaxn=fmaxd/(Fs/2);
% [b,a]=butter(1,fmaxn,'low');
% dd=filtfilt(b,a,dataOut);%通过5Hz低通滤波器的信号
% dataOut=dataOut-dd;          %去除这一段信号，得到去基线漂移的信号

% % 使用小波变换去除基线漂移
% level = 4; % 小波变换的分解层数
% wavelet_type = 'db4'; % 小波基类型
% 
% % 进行小波分解
% [c, l] = wavedec(dataOut, level, wavelet_type);
% 
% % 将最后一层小波系数设为零，以去除低频分量
% c(l(1)+1:end) = 0;
% 
% % 重构信号
% dataOut = waverec(c, l, wavelet_type);

% 低通滤波
% 设定低通滤波器参数
cutoff_frequency = 30; % 截止频率，根据工频的具体情况调整

% 设计低通滤波器
[b, a] = butter(4, cutoff_frequency/(Fs/2), 'low');

% 使用低通滤波器去除工频干扰
dataOut = filtfilt(b, a, dataIn);

% 中值滤波
% 设定中值滤波窗口大小
window_size = 101; % 选择一个奇数窗口大小，根据实际情况调整

% 使用中值滤波去除基线漂移
dataOut = medfilt1(dataOut, window_size);


