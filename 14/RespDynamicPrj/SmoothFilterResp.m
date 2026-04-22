function dataOut = SmoothFilterResp(dataIn)
% 对原始的呼吸信号进行平滑滤波
%   输入参数dataIn为滤波前的数据
%   输出参数dataOut为滤波后的数据
%   COPYRIGHT 2018-2020 LEYUTEK. All rights reserved.

b = [1 1 1 1 1 1 1 1 1 1 1 1] / 12; % 取平均
dataOut = filter(b, 1, dataIn); % 进行平滑滤波