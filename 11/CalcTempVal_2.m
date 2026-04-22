function [temp1, temp2] = CalcTempVal_2(C1, C2, adT1, adT2)
    % 计算体温值，手写实现二分法进行查找
    % 输入参数adT1和adT2分别为体温探头1和2的采样值，这些值均在0至4095之间
    % 输出参数temp1和temp2分别为体温探头1和2的体温值
    % COPYRIGHT 2018-2020 LEYUTEK. All rights reserved.

    TR_TABLE = xlsread('TRTable.csv', 'A1:A502'); % 读取体温的R值表

    meanT1 = nanmean(adT1); % 计算平均值
    meanT2 = nanmean(adT2); % 计算平均值
    VT1 = 5 * meanT1 / 4095; % 转换为电压值
    VT2 = 5 * meanT2 / 4095; % 转换为电压值

    % 计算探头1和2的电阻值r1和r2
    devRes = 1500; % 偏差电阻
    R1 = 10 * C1 * VT1 / (C2 - VT1) + devRes;
    R2 = 10 * C1 * VT2 / (C2 - VT2) + devRes;

    % 使用手写二分法查找温度值
    temp1 = findTemperature(R1, TR_TABLE);
    temp2 = findTemperature(R2, TR_TABLE);

    % 在命令行窗口显示体温值
    disp(['体温1：' num2str(temp1) '℃' ',' '体温2：' num2str(temp2) '℃']);
end

function temperature = findTemperature(resistance, TR_TABLE)
    % 手写二分法查找电阻对应的温度值
    low = 1;
    high = length(TR_TABLE);

    while low <= high
        mid = floor((low + high) / 2);

        if TR_TABLE(mid) == resistance
            temperature = 0.1 * (mid - 1);
            return;
        elseif TR_TABLE(mid) < resistance
            low = mid + 1;
        else
            high = mid - 1;
        end
    end

    % 如果未找到，返回-100表示错误
    temperature = -100;
end
