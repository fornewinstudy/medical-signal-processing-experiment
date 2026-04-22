function respRate = CalcRespRate(dataIn)
% 计算呼吸率
%   输入参数dataIn为波形数据
%   输出参数respRate为呼吸率
%   COPYRIGHT 2018-2020 LEYUTEK. All rights reserved.

MIN_RESP_RATE = 0;   % 呼吸率最小值
MAX_RESP_RATE = 120; % 呼吸率最大值

[~, index] = findpeaks(dataIn, 'minpeakdistance', 250, 'minpeakheight', max(dataIn) - 100);

arrX = zeros(length(index) - 1, 1); % 预分配内存
for iCnt = 1 : length(index) - 1
    arrX(iCnt) = (index(iCnt + 1) - index(iCnt));
end

medianY = median(arrX); % 求数组的中值
respRate = int16(30000 / medianY); % 转换为bpm为单位的呼吸率值，并取值为整数

if respRate < MIN_RESP_RATE || respRate > MAX_RESP_RATE 
    respRate = int16(-100); % 赋值为无效值
end 