function [temp1, temp2] = CalcTempVal_3(C1, C2, adT1, adT2)
    % 计算体温值，使用多项式拟合法
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


    % 多项式拟合，使用3次多项式
    n=0:length(TR_TABLE)-1;
    p=polyfit(TR_TABLE,n,3);
    
    % 使用拟合多项式计算温度值
    temp1=polyval(p,R1)/10;
    temp2=polyval(p,R2)/10;
    
    % 在命令行窗口显示体温值
    disp(['体温1：' num2str(temp1) '℃' ',' '体温2：' num2str(temp2) '℃']);
end
